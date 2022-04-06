//
//  ViewController.swift
//  Homework9App
//
//  Created by 1 on 25.10.2021.
//

import UIKit
import Alamofire
import SDWebImage
import RealmSwift

class MainViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var mainViewModel: MainViewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    private func registerCell() {
        collectionView.register(ActorCollectionViewCell.nib(), forCellWithReuseIdentifier: ActorCollectionViewCell.identifier)
    }
    
    private func loadData() {
        self.mainViewModel.loadMovies {
            self.tableView.reloadData()
        }
        self.mainViewModel.loadActors {
            self.collectionView.reloadData()
        }
    }
    
    private func addToWatchLaterButtonPressed(movie: Movies?) {
        
        self.mainViewModel.saveMovieInRealm(movie, completion: {
            
            let alert = UIAlertController(title: Constant.savedMessage.saved,
                                          message: nil,
                                          preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: Constant.savedMessage.done,
                                          style: UIAlertAction.Style.default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.mainViewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(describing: MainTableViewCell.self)
        let movies = self.mainViewModel.movies[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MainTableViewCell
        else {
            return UITableViewCell()
        }
        cell.posterTitleLabel?.text = movies.title
        cell.releaseDateLabel?.text = movies.firstAirDate
        if let avarage = movies.voteAverage {
            cell.voteAvarageLabel.text = "\(avarage)"
        }
        if let imagePath = movies.posterPath {
            let pathString = Constant.ui.imageUrl + imagePath
            
            cell.posterImage.sd_setImage(with: URL(string: pathString),
                                         placeholderImage: UIImage.init(systemName: "user"))
        }
        cell.backgroundColor = .black
        tableView.backgroundColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let movies = self.mainViewModel.movies[indexPath.row]
        
        let action = UIContextualAction(style: .normal,
                                        title: Constant.titles.cellActionTitle) { [weak self] (action, view, completionHandler) in
            self?.addToWatchLaterButtonPressed(movie: movies)
            completionHandler(true)
        }
        action.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let identifier = String(describing: DetailViewController.self)
        let movies = self.mainViewModel.movies[indexPath.row]
        
        if let detailViewController = self.storyboard?.instantiateViewController(identifier: identifier) as? DetailViewController {
            detailViewController.detailViewModel.movie = movies
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mainViewModel.actors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellIdentifier = String(describing: ActorCollectionViewCell.self)
        let actors = self.mainViewModel.actors[indexPath.row]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                            for: indexPath) as? ActorCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configureWith(actorName: actors.name, imagePath: actors.profilePath)
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 140)
    }
}


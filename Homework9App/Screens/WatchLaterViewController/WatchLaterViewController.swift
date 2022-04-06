//
//  WatchLaterViewController.swift
//  Homework9App
//
//  Created by 1 on 01.11.2021.
//

import UIKit
import RealmSwift

class WatchLaterViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try? Realm()
    
    private var watchLaterViewModel: WatchLaterViewModel = WatchLaterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getMovies()
    }
    
    private func getMovies() {
        self.watchLaterViewModel.getAllMovies {
            self.tableView.reloadData()
        }
    }
    
    private func deleteMovieFromRealm(movie: Movies?) {
        
        self.watchLaterViewModel.deletedMovieFromRealm(movie, completion: {
            
            let alert = UIAlertController(title: Constant.savedMessage.deleted,
                                          message: nil,
                                          preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: Constant.savedMessage.done,
                                          style: UIAlertAction.Style.default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
    }
}

extension WatchLaterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.watchLaterViewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = String(describing: WatchLaterCustomTableViewCell.self)
        let movies = self.watchLaterViewModel.movies[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? WatchLaterCustomTableViewCell
        else {
            return UITableViewCell()
        }
        cell.posterTitleLabel?.text = movies.title
        if let avarage = movies.popularity {
            cell.voteAvarageLabel.text = "\(avarage)"
        }
        if let imagePath = movies.posterPath {
            let pathString = Constant.ui.imageUrl + imagePath
            
            cell.posterImageView.sd_setImage(with: URL(string: pathString),
                                             placeholderImage: UIImage.init(systemName: "user"))
        }
        
        cell.posterTitleLabel.textColor = .white
        cell.voteAvarageLabel.textColor = .red
        cell.backgroundColor = .black
        tableView.backgroundColor = .black
        return cell
    }
//        Вот здесь я столкнулся с этими трудностями
        
        func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
            let editingRow = watchLaterViewModel.movies[indexPath.row]
    
            let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { [weak self] _,_ in
//                self?.deleteMovieFromRealm(movie: editingRow)
            }
            return [deleteAction]
        }
}

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

class MainViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Result] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let imageUrl = "https://image.tmdb.org/t/p/w500/"
    let realm = try! Realm()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        parseData()
        searchBar()
    }
    
    
    func parseData() {
        
        let url = "https://api.themoviedb.org/3/trending/tv/week?api_key=e98bfe9a7d1f9871d54625e27d59ee6d"
        
        AF.request(url).responseJSON { response in
            
            let decoder = JSONDecoder()
            
            if let data = try? decoder.decode(JsonResult.self, from: response.data!) {
                self.movies = data.results ?? []
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
    }
    
    @objc func handleMarkAsFavourite(description: String?) {
        let watchLaterMovie = WatchLaterMovies()
        watchLaterMovie.titleOfMovie = "\(String(describing: description!))"
        
        try! realm.write {
            realm.add(watchLaterMovie)
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseCell = "CustomTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseCell) as? CustomTableViewCell
        else {
            return UITableViewCell()
        }
        cell.posterTitleLabel?.text = self.movies[indexPath.row].title
        cell.releaseDateLabel?.text = self.movies[indexPath.row].firstAirDate
        if let avarage = movies[indexPath.row].voteAverage {
            cell.voteAvarageLabel.text = "\(avarage)"
        }
        if let imagePath = movies[indexPath.row].posterPath {
            let pathString = imageUrl + imagePath
            
            cell.posterImage.sd_setImage(with: URL(string: pathString),
                                         placeholderImage: UIImage.init(systemName: "user"))
        }
        
        cell.backgroundColor = .black
        tableView.backgroundColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal,
                                        title: "Watch later") { [weak self] (action, view, completionHandler) in
                self?.handleMarkAsFavourite(description: self?.movies[indexPath.row].title)
                completionHandler(true)
        }
        action.backgroundColor = .systemYellow
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let identifier = String(describing: DetailViewController.self)
        
        if let detailViewController = self.storyboard?.instantiateViewController(identifier: identifier) as? DetailViewController {
            detailViewController.movie = self.movies[indexPath.row]
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }
    }
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
}


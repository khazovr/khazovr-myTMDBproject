//
//  WatchLaterViewController.swift
//  Homework9App
//
//  Created by 1 on 01.11.2021.
//

import UIKit
import RealmSwift

class WatchLaterViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
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
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//        let editingRow = watchLaterViewModel.movies[indexPath.row]
//
//        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { _,_ in
//            try? self.realm?.write {
//            self.realm?.delete(editingRow)
//            tableView.reloadData()
//            }
//        }
//        return [deleteAction]
//    }
}

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
    
    let realm = try! Realm()
    var watchLaterArray: Results<WatchLaterMovies>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDataBase()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func showDataBase() {
        watchLaterArray = realm.objects(WatchLaterMovies.self)
    }
}

extension WatchLaterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if watchLaterArray.count != 0 {
            return watchLaterArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let identifier = "watchLaterCells"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        let item = watchLaterArray[indexPath.row]
        cell.textLabel?.text = item.titleOfMovie
        
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        tableView.backgroundColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editingRow = watchLaterArray[indexPath.row]
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { _,_ in
            try! self.realm.write {
                self.realm.delete(editingRow)
                tableView.reloadData()
            }
        }
        return [deleteAction]
    }
}

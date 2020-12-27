//
//  FilmesTableViewController.swift
//  Must-See
//
//  Created by Kelvin Batista Machado on 24/11/20.
//

import UIKit
import RealmSwift

class FilmesTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var filmes: Results<Filme>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Lista de filmes"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        loadCategories()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filmes!.count == 0 {
            return 1
        } else {
            return  filmes!.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if filmes!.count == 0 {
            cell.textLabel?.text = "Adicione Filmes"
        } else {
            if let item = filmes?[indexPath.row] {
                cell.textLabel?.text = item.title
                cell.accessoryType = item.watched ? .checkmark : .none
            } else {
                cell.textLabel?.text = "Adicione Filmes"
            }
        }
        return cell
    }
    
    func loadCategories() {
        filmes = realm.objects(Filme.self)
        tableView.reloadData()
    }
}

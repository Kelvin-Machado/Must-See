//
//  FilmesTableViewController.swift
//  Must-See
//
//  Created by Kelvin Batista Machado on 24/11/20.
//

import UIKit
import RealmSwift
import SwipeCellKit

class FilmesTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var filmes: Results<Filme>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Lista de filmes"
        tableView.rowHeight = 65.0
        
        tableView.register(SwipeTableViewCell.self, forCellReuseIdentifier: "cell")
        loadFilmes()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmes?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SwipeTableViewCell
        
        cell.delegate = self
        
        if let item = filmes?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.watched ? .checkmark : .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = filmes?[indexPath.row] {
            do {
                try realm.write{
                    item.watched = !item.watched
                }
            } catch {
                print("Erro ao salvar watched status, \(error)")
            }
        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func loadFilmes() {
        filmes = realm.objects(Filme.self).sorted(byKeyPath: "title", ascending: true)
        tableView.reloadData()
    }
}


//MARK: - Swipe Cell Delegate Methods

extension FilmesTableViewController: SwipeTableViewCellDelegate  {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil}
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { [self] (action, indexPath) in
            
            
            if let item = filmes?[indexPath.row] {
                do {
                    try realm.write{
                        realm.delete(item)
                    }
                } catch {
                    print("Error deleting item, \(error)")
                }
            }
            
        }
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        options.transitionStyle = .border
        return options
    }
}

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
        
        
        
        let mySwitch = UISwitch()
        mySwitch.addTarget(self, action: #selector(didChangeSwitch), for: .valueChanged)
        cell.accessoryView = mySwitch
        
        
        if filmes!.count == 0 {
            cell.textLabel?.text = "Adicione Filmes"
            mySwitch.isHidden = true
        } else {
            cell.textLabel?.text = filmes![indexPath.row].title
            if filmes![indexPath.row].watched {
                mySwitch.isOn = true
            } else {
                mySwitch.isOn = false
            }
        }
        
        return cell
    }
    
    @objc func didChangeSwitch(_ sender: UISwitch) {
        if sender.isOn {
            print("Is On")
        } else {
            print("Is off")
        }
    }
    
    func loadCategories() {
        filmes = realm.objects(Filme.self)
        tableView.reloadData()
    }
}

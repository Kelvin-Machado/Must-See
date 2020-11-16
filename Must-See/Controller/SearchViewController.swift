//
//  SearchViewController.swift
//  Must-See
//
//  Created by Kelvin Batista Machado on 03/11/20.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var movieView: UIView!
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        configureNavigationBar(largeTitleColor: .white, backgoundColor: .purple, tintColor: .white, title: "Must-see", preferredLargeTitle: true)
        
        searchBar.searchTextField.backgroundColor = .white
        movieView.layer.cornerRadius = 10
        posterImg.layer.cornerRadius = 5
        
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        movieView.isHidden = true
    }
    
}


// MARK: - SearchBar

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.isEmpty {
            movieView.fadeOut()
        } else {
            movieView.isHidden = false
            movieView.fadeIn()
        }
    }
    
}

//
//  SearchViewController.swift
//  Must-See
//
//  Created by Kelvin Batista Machado on 03/11/20.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigationBar(largeTitleColor: .white, backgoundColor: .purple, tintColor: .white, title: "Must-see", preferredLargeTitle: true)
        
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
}

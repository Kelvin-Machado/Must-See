//
//  PosterViewController.swift
//  Must-See
//
//  Created by Kelvin Batista Machado on 18/11/20.
//

import UIKit

class PosterViewController: UIViewController {

    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var infoBtn: UIButton!
    
    let button = UIButton(type: .system)
       
    
    var movieTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(named: "addBtn.png"), for: .normal)
        button.setTitle(" Adicionar", for: .normal)
        button.sizeToFit()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        button.addTarget(self, action: #selector(self.addItem), for: .touchUpInside)
        
        infoBtn.titleLabel?.textAlignment = .center
        infoBtn.layer.cornerRadius = 10
        posterImg.layer.cornerRadius = 5
    }
    

    @objc func addItem() {
        print("Clicado")
    }

}

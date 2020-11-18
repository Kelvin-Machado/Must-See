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
    @IBOutlet weak var addBtn: UIBarButtonItem!
    
    var movieTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        infoBtn.titleLabel?.textAlignment = .center
        infoBtn.layer.cornerRadius = 10
        posterImg.layer.cornerRadius = 5
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

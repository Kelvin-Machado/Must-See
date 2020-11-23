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
    var posterDownloadedImg: UIImage!
    
    private lazy var setupLargeTitleLabelOnce: Void = {[unowned self] in
        if #available(iOS 11.0, *) {
            self.setupLargeTitleAutoAdjustFont()
        }
    }()
    
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
        posterImg.layer.cornerRadius = 10
        
        self.title = movieTitle
        posterImg.image = posterDownloadedImg
        
        print(movieTitle)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let _ = setupLargeTitleLabelOnce
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if #available(iOS 11.0, *) {
            setupLargeTitleAutoAdjustFont()
        }
    }
    
    func setupLargeTitleAutoAdjustFont() {
        guard let navigationBar = navigationController?.navigationBar else {
            return
        }
        // recursively find the label
        func findLabel(in view: UIView) -> UILabel? {
            if view.subviews.count > 0 {
                for subview in view.subviews {
                    if let label = findLabel(in: subview) {
                        return label
                    }
                }
            }
            return view as? UILabel
        }

        if let label = findLabel(in: navigationBar) {
            if label.text == self.title {
                label.adjustsFontSizeToFitWidth = true
                label.minimumScaleFactor = 0.4
            }
        }
    }
    

    @objc func addItem() {
        print("Clicado")
    }

}

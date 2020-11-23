//
//  InfoViewController.swift
//  Must-See
//
//  Created by Kelvin Batista Machado on 22/11/20.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var tituloLbl: UILabel!
    @IBOutlet weak var sinopseTxtView: UITextView!
    @IBOutlet weak var notasLbl: UILabel!
    @IBOutlet weak var infoTxtView: UITextView!
    
    var infoView: OMDb?
    var poster: UIImage?
    var viewPoster: UIView?
    var imageView: UIImageView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        infoTxtView.isScrollEnabled = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tituloLbl.text = "\(infoView!.title) (\(infoView!.year))"
        sinopseConfig()
        notasConfig()
        infoConfig()
        
    }
    
    func sinopseConfig() {
        
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 150, height: 200))
        sinopseTxtView.textContainer.exclusionPaths = [path]
        
        imageView = UIImageView(image: poster!.resize(380))
        
        sinopseTxtView.addSubview(imageView!)
        sinopseTxtView.text = infoView?.plot
        sinopseTxtView.layer.cornerRadius = 5
        
    }
    
    func notasConfig() {
    
        let notas = infoView!.ratings.count
        
        if notas != 0 {
            notasLbl.text = "\n"
            for source in 0...notas-1 {
                notasLbl.text?.append(contentsOf: "   \(infoView!.ratings[source].source): \(infoView!.ratings[source].value) \n")
            }
        } else {
            print("Sem avaliações" )
        }
        
        notasLbl.clipsToBounds = true
        notasLbl.layer.cornerRadius = 5
        
    }
    
    func infoConfig() {
        
        infoTxtView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            infoTxtView.topAnchor.constraint(equalTo: notasLbl.bottomAnchor, constant: 8),
            infoTxtView.heightAnchor.constraint(lessThanOrEqualToConstant: 200),
            infoTxtView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            infoTxtView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            infoTxtView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12)
        ])
        
        infoTxtView.layer.cornerRadius = 5
        infoTxtView.text = " Director: \(infoView!.director!)\n\n Runtime: \(infoView!.runtime!)\n\n Genre: \(infoView!.genre!) \n"
    }
}


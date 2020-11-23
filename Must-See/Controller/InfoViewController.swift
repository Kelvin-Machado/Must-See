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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tituloLbl.text = "\(infoView!.title) (\(infoView!.year))"
        
        let path = UIBezierPath(rect: CGRect(x: 0, y: 0, width: 150, height: 200))
        sinopseTxtView.textContainer.exclusionPaths = [path]
        
        imageView = UIImageView(image: poster!.resize(380))
        
        sinopseTxtView.addSubview(imageView!)
        
        sinopseTxtView.text = infoView?.plot
        sinopseTxtView.isSelectable = false
        sinopseTxtView.isEditable = false
        infoTxtView.isSelectable = false
        infoTxtView.isEditable = false
        
        let notas = infoView!.ratings.count
        
        if notas != 0 {
            notasLbl.text = "\n"
            for source in 0...notas-1 {
                notasLbl.text?.append(contentsOf: " \(infoView!.ratings[source].source): \(infoView!.ratings[source].value) \n")
            }
        } else {
            print("Sem avaliações" )
        }
        
        infoTxtView.text = " Director: \(infoView!.director!)\n Runtime: \(infoView!.runtime!)\n Genre: \(infoView!.genre!) \n"
        
        sinopseTxtView.layer.cornerRadius = 5
        notasLbl.clipsToBounds = true
        notasLbl.layer.cornerRadius = 5
        infoTxtView.layer.cornerRadius = 5
        
    }
}

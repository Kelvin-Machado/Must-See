//
//  PosterViewController.swift
//  Must-See
//
//  Created by Kelvin Batista Machado on 18/11/20.
//

import UIKit
import RealmSwift

class PosterViewController: UIViewController {
    
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var addBtn: UIBarButtonItem!
    
    var infoPoster: OMDb?
    var posterDownloadedImg: UIImage!
    
    let realm = try! Realm()
    var filme: Results<Filme>?
    
    private lazy var setupLargeTitleLabelOnce: Void = {[unowned self] in
        if #available(iOS 11.0, *) {
            self.setupLargeTitleAutoAdjustFont()
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filme = realm.objects(Filme.self)
        
        addBtn.action = #selector(addItem)
        addBtn.target = self
        
        infoBtn.titleLabel?.textAlignment = .center
        infoBtn.layer.cornerRadius = 10
        infoBtn.layer.borderWidth = 3
        infoBtn.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        posterImg.layer.cornerRadius = 10
        posterImg.layer.borderWidth = 2
        posterImg.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        self.title = infoPoster?.title
        posterImg.image = posterDownloadedImg
        
        print(infoPoster?.title ?? "Título não informado")
        
    }
    
    //MARK: - Redimensionar títulos
    
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
    
    
    //MARK: - Adicionar títulos à lista
    
    @objc func addItem() {
        print("Clicado")
        let sucesso = true
        let newItem = Filme()
        newItem.title = infoPoster?.title ?? ""
        newItem.releaseDate = Date()
        newItem.searchedTitle = infoPoster?.title ?? ""
        newItem.watched = false
        
        do {
            try realm.write {
                realm.add(newItem)
                showAlert(sucesso: sucesso)
            }
        } catch {
            print("Error saving new movie \(error)")
            showAlert(sucesso: !sucesso)
        }
    }
    
    func showAlert(sucesso: Bool) {
        var msg = ""
        var titulo = ""
        sucesso ? (msg = "Item salvo na lista") : (msg = "Não foi possível salvar esse item")
        sucesso ? (titulo = "Sucesso!!!") : (titulo = "Erro")
        let alert = UIAlertController(title: titulo, message: msg, preferredStyle: .alert)
    
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: msg as String, attributes: [NSAttributedString.Key.font:UIFont(name: "HelveticaNeue-Medium", size: 14.0)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.blue, range: NSRange(location:0,length:msg.count))
        alert.setValue(myMutableString, forKey: "attributedMessage")
        
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.lightGray
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style {
              case .default:
                    print("default")

              case .cancel:
                    print("cancel")

              case .destructive:
                    print("destructive")

              @unknown default:
                fatalError()
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is InfoViewController {
            let vc = segue.destination as? InfoViewController
            vc?.infoView = infoPoster!
            vc?.poster = posterDownloadedImg
        }
    }
    
}

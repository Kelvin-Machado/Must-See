//
//  SearchViewController.swift
//  Must-See
//
//  Created by Kelvin Batista Machado on 03/11/20.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var movieView: UIView!
    @IBOutlet weak var posterImg: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var movieBtn: UIButton!
    
    var searchingMovie = ""
    var info: OMDb?
    var textEditing = ""
    
    var posterVC = PosterViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        configureNavigationBar(largeTitleColor: .white, backgoundColor: .purple, tintColor: .white, title: "Must-see", preferredLargeTitle: true)
        
        searchBar.searchTextField.backgroundColor = .white
        
        posterImg.layer.cornerRadius = 5
        
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        movieView.isHidden = true
    }
    func loadMovie() {
        
        posterImg.load(url: URL(string: (info?.poster)!)!)
        titleLbl.text = info?.title
        yearLbl.text = ("(\(info!.year))")
        movieView.layer.cornerRadius = 10
    }
    
    func fetchMovieInfo(movieName: String) {
        
        searchingMovie = movieName.replacingOccurrences(of: " ", with: "+", options: NSString.CompareOptions.literal, range:nil)
        
        print(searchingMovie)
        
        let contatosString = ("http://www.omdbapi.com/?apikey=49b353cf&t=\(searchingMovie)")
        guard let url = URL(string: contatosString) else { return }

        URLSession.shared.dataTask(with: url) { (data, _, _) in

            guard let data = data else { return }

            do {
                let infoBaixada = try
                    JSONDecoder().decode(OMDb.self, from: data)
                self.info = infoBaixada
                DispatchQueue.main.async {
                    self.loadMovie()
                }
            } catch let jsonError {
                print("Error serializing json:", jsonError)
            }
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is PosterViewController {
            let vc = segue.destination as? PosterViewController
            vc?.posterDownloadedImg = posterImg.image
            vc?.infoPoster = info!
            
            
        }
    }
    
}


// MARK: - SearchBar

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        textEditing = searchText
        
        if searchText == "" {
            movieView.fadeOut()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                posterImg.image = #imageLiteral(resourceName: "testeIMG")
                titleLbl.text = "Original Title"
                yearLbl.text = ("(year)")
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text!.isEmpty {
            movieView.fadeOut()
        } else {
            fetchMovieInfo(movieName: textEditing)
            movieView.isHidden = false
            IQKeyboardManager.shared.resignFirstResponder()
            movieView.fadeIn()
        }
    }
    
}

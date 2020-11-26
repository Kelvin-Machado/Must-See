//
//  Filme.swift
//  Must-See
//
//  Created by Kelvin Batista Machado on 25/11/20.
//

import Foundation
import RealmSwift

class Filme: Object {
    @objc dynamic var title: String = ""
    @objc dynamic var searchedTitle: String = ""
    @objc dynamic var releaseDate: Date?
    @objc dynamic var watched: Bool = false
}

//
//  realmDB.swift
//  Rest API
//
//  Created by Singh, Akash | RIEPL on 31/05/22.
//  Copyright © 2022 Niso. All rights reserved.
//

import Foundation
import RealmSwift

class MovieCell: Object, Codable {
    @objc dynamic var movieTitle: String = ""
    @objc dynamic var moviePoster: String = ""
    @objc dynamic var movieDetails: String = ""
    @objc dynamic var movieSummary: String = ""

convenience init(mTitle: String, mPoster: String, mDetails: String, mSummary: String) {
    self.init()
    self.movieTitle = mTitle
    self.moviePoster = mPoster
    self.movieDetails = mDetails
    self.movieSummary = mSummary
}
}

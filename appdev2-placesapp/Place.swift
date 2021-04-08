//
//  Place.swift
//  appdev2-placesapp
//
//  Created by Chow Kim Foong on 28/3/21.
//

import UIKit

class Place: SQLTable {
    var id: Int = -1
    var name: String = ""
    var desc: String = ""
    var rating: Int = 0
    var image: String = ""
    
    init(name: String, desc: String, rating: Int, image: String)
    {
        self.name = name
        self.desc = desc
        self.rating = rating
        self.image = image
    }
    
    required init() {
    }


}

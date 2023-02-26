//
//  Model.swift
//  3HomeWork
//
//  Created by Байгелди Акылбек уулу on 12/2/23.
//

import Foundation
import UIKit
struct Coctail: Decodable{
    let drinks: [Drinks]
}

struct Drinks: Decodable {
    let strDrink: String
    let strDrinkThumb: String
}



struct Review: Codable{
    var username: String
    var prodName: String
    var comment: String
    var rate: String
    var date: String
}



struct Product: Codable{
    var name: String
    var image: String
    var count: String
    var price: String
    var rate: String
}


struct User: Codable{
    var username: String
    var number: String
    var date: String
    var addres: String
}

  

//
//  SaveToUserDefaults.swift
//  3HomeWork
//
//  Created by Байгелди Акылбек уулу on 23/2/23.
//

import Foundation

class UsDef{
    
    static let shared = UsDef()
    
    var defaults = UserDefaults.standard
    
    
    
    var savedProductsArray: [Product]{
        get{
            if let data = defaults.value(forKey: "savedProductsArray") as? Data{
                return try! PropertyListDecoder().decode([Product].self,from: data)
            } else{
                return [Product]()
            }
        }set{
            if let data = try? PropertyListEncoder().encode(newValue){
                defaults.set(data, forKey: "savedProductsArray")
            }
        }
    }
    
    func saveProducts(name: String, image: String, count: String, price: String, rate: String){
        let product = Product(name: name, image: image, count: count, price: price, rate: rate)
        savedProductsArray.insert(product, at: 0)
    }
    
    
    
    var savedReviewsArray: [Review]{
        get{
            if let data = defaults.value(forKey: "savedReviewsArray") as? Data{
            return try! PropertyListDecoder().decode([Review].self,from: data)
        } else{
            return [Review]()
        }
    }set{
        if let data = try? PropertyListEncoder().encode(newValue){
            defaults.set(data, forKey: "savedReviewsArray")
        }
    }
}
    
    
    func saveReviews(username: String, prodName: String, comment: String, rate: String, date: String){
        let review = Review(username: username, prodName: prodName, comment: comment, rate: rate, date: date)
        savedReviewsArray.insert(review, at: 0)
    }
    
    
    
    var savedUsersArray: [User]{
        get{
            if let data = defaults.value(forKey: "savedUsersArray") as? Data{
            return try! PropertyListDecoder().decode([User].self,from: data)
        } else{
            return [User]()
        }
    }set{
        if let data = try? PropertyListEncoder().encode(newValue){
            defaults.set(data, forKey: "savedUsersArray")
        }
    }
}
    
    
    func saveUser(username: String, number: String, date: String, addres: String){
        let user = User(username: username, number: number, date: date, addres: addres)
        savedUsersArray.insert(user, at: 0)
    }
}

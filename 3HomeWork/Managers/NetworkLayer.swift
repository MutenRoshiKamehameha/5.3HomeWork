//
//  NetworkManager.swift
//  3HomeWork
//
//  Created by Байгелди Акылбек уулу on 12/2/23.
//


import Foundation
import UIKit

final class NetworkLayer {
    static let shared = NetworkLayer()
    
    let baseURL = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic")!
    
    func fetchData() async throws -> Coctail {
        let (data,_) = try await URLSession.shared.data(from: baseURL)
        return try await decodeData(data: data)
    }
    
    private func decodeData<T: Decodable>(data: Data) async throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
    
}

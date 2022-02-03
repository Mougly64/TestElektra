//
//  TvShowProvider.swift
//  TestElerktra
//
//  Created by Luan Road on 02/02/22.
//

import Foundation

final class TvShowProvider {
    static let shared = TvShowProvider()
    
    /// method who return all the elements from the api
    /// - Parameters:
    ///   - success: completation handler with the list of elements from the api in a list of structs
    ///   - failure: completation handler with the error from the api or decoder
    func getAllShows(success: @escaping(_ tvShows: [TvShow]) -> (), failure: @escaping(_ error: Error?)->()) {
        guard let url = URL(string: "\(Constants.baseEndPoint)shows")
        else
        {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let json = data else { return }
            
            if let data = data {
                     if let jsonString = String(data: data, encoding: .utf8) {
                        print(jsonString)
                     }
                   }
            do{
                let decoder = JSONDecoder()
                success(try decoder.decode([TvShow].self, from: json))
            }catch let error {
                failure(error)
            }
        }.resume()
    }
    
    /// method who fetch an element from the api
    /// - Parameters:
    ///   - success: completation handler who return the object
    ///   - failure: completition handler who return the error from the api
    func getAShow(success: @escaping(_ tvShow: TvShow) -> (), failure: @escaping(_ error: Error?) -> ()) {
        guard let url = URL(string: "\(Constants.baseEndPoint)shows/1")
        else
        {
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let json = data else { return }
            
            if let data = data {
                     if let jsonString = String(data: data, encoding: .utf8) {
                        print(jsonString)
                     }
                   }
            do{
                let decoder = JSONDecoder()
                success(try decoder.decode(TvShow.self, from: json))
            }catch let error {
                print(String(describing: error))
                failure(error)
            }
        }.resume()
    }
}

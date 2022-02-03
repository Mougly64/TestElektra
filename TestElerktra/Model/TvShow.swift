//
//  TvShow.swift
//  TestElerktra
//
//  Created by Luan Road on 02/02/22.
//

import Foundation
import UIKit

/// struct with a decodable
struct TvShow: Decodable {
    let id: Int?
    let name, type, language: String?
    let image: [String:String]?
    let summary: String
    let externals: Externals
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case type
        case language
        case image
        case summary
        case externals
    }
}

/// struct decodable
struct Externals: Decodable {
    let tvrage: Int?
    let thetvdb: Int?
    let imdb: String?
}

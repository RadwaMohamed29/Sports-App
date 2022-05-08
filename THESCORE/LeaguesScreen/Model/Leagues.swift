//
//  Leagues.swift
//  Sports App
//
//  Created by Radwa on 05/05/2022.
//

import Foundation
import SwiftUI

struct Leagues: Codable{
    let countrys: [Countrys]
}

struct Countrys: Codable{
    let idLeague : String
    let strSport : String
    let strLeague : String
    let strCountry : String
    let strYoutube : String
    let strBadge : String
    
    enum CodingKeys : String, CodingKey{
        case idLeague = "idLeague"
        case strSport = "strSport"
        case strLeague = "strLeague"
        case strCountry = "strCountry"
        case strYoutube = "strYoutube"
        case strBadge = "strBadge"
        
    }
}

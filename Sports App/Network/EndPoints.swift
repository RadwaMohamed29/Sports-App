//
//  EndPoints.swift
//  Sports App
//
//  Created by mac hub on 03/05/2022.
//

import Foundation


enum EndPoints {
    case allSpors  //"/all_sports.php"
    case countries//"/all_countries.php"
    case searchAllLeagues(country:String,sport:String )
    var path:String{
        switch self {
        case .allSpors:
            return "/all_sports.php"
        case .countries:
            return "/all_countries.php"
        case .searchAllLeagues(let country, let sport):
            return "/search_all_leagues.php?c=\(country)&s=\(sport)"
        }
    }
//    case searchAllLeagues = "/search_all_leagues.php"
//    case league = "/search_all_leagues.php?c=England&s=Soccer"
 
    
}


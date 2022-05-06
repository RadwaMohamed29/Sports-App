//
//  EndPoints.swift
//  Sports App
//
//  Created by mac hub on 03/05/2022.
//

import Foundation


enum EndPoints {
    case allSpors
    case countries
    case searchAllLeagues(country:String,sport:String )
    case searchAllTeams(country: String , sport: String)
    
    var path:String{
        switch self {
        case .allSpors:
            return "/all_sports.php"
        case .countries:
            return "/all_countries.php"
        case .searchAllLeagues(let country, let sport):
            return "/search_all_leagues.php?c=\(country)&s=\(sport)"
        case .searchAllTeams(country: let country, sport: let sport):
            return "/search_all_teams.php?s=\(sport)&c=\(country)"
        }
    }
 
    
}


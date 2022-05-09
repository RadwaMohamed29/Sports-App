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
    case searchAllLeagues(country:String,sport:String)
    case searchAllTeams(leagueStr: String)
    case getEventsByTeamId(teamId: String)
    
    
    var path:String{
        switch self {
        case .allSpors:
            return "/all_sports.php"
        case .countries:
            return "/all_countries.php"
        case .searchAllLeagues(let country, let sport):
            return "/search_all_leagues.php?c=\(country)&s=\(sport)"
        case .searchAllTeams(let leagueStr):
            return "/search_all_teams.php?l=\(leagueStr)"
        case .getEventsByTeamId(let teamId):
            return "/eventslast.php?id=\(teamId)"
            
        }
    }
 
    
}


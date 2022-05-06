//
//  Teams.swift
//  Sports App
//
//  Created by mac hub on 06/05/2022.
//

import Foundation

struct Teams: Codable {
    var teams: [Team]
}

struct Team: Codable {
    let teamID:String
    let teamName:String?
    let sportName: String?
    let teamLeague:String?
    let teamFoundedDate:String?
    let teamWebSite:String?
    let teamFacebook:String?
    let teamTwitter:String?
    let teamInstagram:String?
    let teamDiscription:String?
    let teamYoutube:String?
    let teamImage:String?
    let backgroundImage:String?
    let stadiumName:String?
    let stadiumImage:String?
    
    enum CodingKeys: String, CodingKey {
        case teamID = "idTeam"
        case teamName = "strTeam"
        case sportName = "strSport"
        case teamLeague = "strLeague"
        case teamFoundedDate = "intFormedYear"
        case teamWebSite = "strWebsite"
        case teamFacebook = "strFacebook"
        case teamTwitter = "strTwitter"
        case teamInstagram = "strInstagram"
        case teamDiscription = "strDescriptionEN"
        case teamYoutube = "strYoutube"
        case teamImage = "strTeamBadge"
        case backgroundImage = "strTeamFanart1"
        case stadiumName = "strStadium"
        case stadiumImage = "strStadiumThumb"
    }
}

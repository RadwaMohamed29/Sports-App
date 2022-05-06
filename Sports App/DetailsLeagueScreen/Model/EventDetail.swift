//
//  EventDetail.swift
//  Sports App
//
//  Created by mac hub on 05/05/2022.
//

import Foundation

struct LastEvents: Codable {
    let results: [Event]
}

struct Event: Codable {
    let teamVsTeam:String //strEvent
    let homeTeamName:String //strHomeTeam
    let awayTeamName:String //strAwayTeam
    let homeTeamScore:String //intHomeScore
    let awayTeamScore:String //intAwayScore
    let eventDate:String //dateEvent
    let eventTime:String //strTime
    let eventImage:String //strThumb
    let eventHighlights:String //strVideo
    
    enum CodingKeys: String, CodingKey {
        case teamVsTeam = "strEvent"
        case homeTeamName = "strHomeTeam"
        case awayTeamName = "strAwayTeam"
        case homeTeamScore = "intHomeScore"
        case awayTeamScore = "intAwayScore"
        case eventDate = "dateEvent"
        case eventTime = "strTime"
        case eventImage = "strThumb"
        case eventHighlights = "strVideo"
    }
}

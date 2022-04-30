//
//  AllSports.swift
//  Sports App
//
//  Created by mac hub on 29/04/2022.
//

import Foundation

struct AllSports: Codable {
    let sports: [Sport]
}

struct Sport: Codable {
    let id: String
    let sportName: String
    let sportFormat: String
    let sportImage: String
    let sportIconInGreen: String
    let strSportDescription: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idSport"
        case sportName = "strSport"
        case sportFormat = "strFormat"
        case sportImage = "strSportThumb"
        case sportIconInGreen = "strSportIconGreen"
        case strSportDescription = "strSportDescription"
    }
}



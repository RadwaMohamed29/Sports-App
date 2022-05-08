//
//  Countries.swift
//  Sports App
//
//  Created by Mohab El-Ziny on 03/05/2022.
//

import Foundation

struct Countries: Codable {
    var countries: [Country]
}

struct Country: Codable {
    let countryName: String

    enum CodingKeys: String, CodingKey {
        case countryName = "name_en"
    }
}

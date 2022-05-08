//
//  SelectedItems.swift
//  Sports App
//
//  Created by mac hub on 06/05/2022.
//

import Foundation


class SelectedItem {
    var sportName: String
    var countryName: String
    var leagueName: String
    var countrys: Countrys
    
    init(sportName: String, countryName: String, leagueName: String,countrys: Countrys) {
        self.sportName = sportName
        self.countryName = countryName
        self.leagueName = leagueName
        self.countrys = countrys
    }
}

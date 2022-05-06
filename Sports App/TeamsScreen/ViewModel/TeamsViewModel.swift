//
//  TeamsViewModel.swift
//  Sports App
//
//  Created by mac hub on 06/05/2022.
//

import Foundation

protocol AllTeamsProtocol {
    func callFuncToGetAllTeams(completionHandler:@escaping (Bool) -> Void)
    var getTeams: ((AllTeamsProtocol)->Void)? {get set}
    var teamsData: Teams? {get set}
    var selectedItems: SelectedItem? {get set}
}

final class TeamsViewModel: AllTeamsProtocol {
    
    var selectedItems: SelectedItem?
    
    
    let allTeamsProvider: TeamsProvider = APIClient()
    
    var getTeams: ((AllTeamsProtocol) -> Void)?
    
    var teamsData: Teams? {
        didSet {
            getTeams!(self)
        }
    }
    
    
    
    func callFuncToGetAllTeams(completionHandler: @escaping (Bool) -> Void) {
        completionHandler(false)
        guard let selectedItems = selectedItems else {
            return
        }
        

        allTeamsProvider.getTeamsFromApi(strLeague: selectedItems.leagueName) { [weak self] result in
            switch result {
                
            case .success(let teams):
                self?.teamsData = teams
                //self?.filteredArray = teams.teams.filter({$0.teamLeague == selectedItems.league})
                
            case .failure(let error):
                print(error)
            }
        }
        completionHandler(true)
    }
    

    
    
}

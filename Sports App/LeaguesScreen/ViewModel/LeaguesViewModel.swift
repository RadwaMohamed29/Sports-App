//
//  LeaguesViewModel.swift
//  Sports App
//
//  Created by Radwa on 05/05/2022.
//

import Foundation

protocol AllLeaguesProtocol {
    func callFuncToGetAllLeagues(completionHandler:@escaping (Bool) -> Void)
    var getLeagues: ((AllLeaguesProtocol)->Void)? {get set}
    var leagueData: Leagues? {get set}
}
final class LeaguesViewModel: AllLeaguesProtocol{
    
    var getLeagues: ((AllLeaguesProtocol)->Void)?
    
    var  leagueData: Leagues?{
        didSet{
            getLeagues!(self)
        }
    }
    
    let leaguesProvider: LeaguesProvider = APIClient()
    
    func callFuncToGetAllLeagues(completionHandler: @escaping (Bool) -> Void) {
        completionHandler(false)
        leaguesProvider.getLeaguesFromAPI(completion: {[weak self] result in
            switch result{
                
            case .success(let leagues):
                self?.leagueData = leagues
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            completionHandler(true)
            
            
        })
    }
    
}

//
//  LeaguesViewModel.swift
//  Sports App
//
//  Created by Radwa on 05/05/2022.
//

import Foundation
import UIKit

protocol AllLeaguesProtocol {
    func callFuncToGetAllLeagues(completionHandler:@escaping (Bool) -> Void)
    var getLeagues: ((AllLeaguesProtocol)->Void)? {get set}
    var leagueData: Leagues? {get set}
    func openYoutube(url:String)
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
    
    func openYoutube(url:String){
        let application = UIApplication.shared
        if application.canOpenURL(URL(string: url)!) {
            application.open(URL(string: url)!)
        }else {
            application.open(URL(string: "https://\(url)")!)
        }
    }
    
}

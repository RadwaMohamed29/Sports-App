//
//  FavoritesViewModel.swift
//  Sports App
//
//  Created by Mohab El-Ziny on 05/05/2022.
//

import Foundation
protocol FavoritesProtocol {
    func callFuncToGetFavoriteLeagues(completionHandler:@escaping (Bool) -> Void)
    var getLeagues: ((FavoritesProtocol)->Void)? {get set}
    var LeaguesData: AllSports? {get set}
}

final class FavoritesViewModel:FavoritesProtocol{
    private let localService:LocalService
    
    init(appDelegate:AppDelegate){
        localService = LocalSource(appDelegate: appDelegate)
    }
    
    func callFuncToGetFavoriteLeagues(completionHandler: @escaping (Bool) -> Void) {
        completionHandler(false)
        do{
            try localService.getFavoriteLeguesDataFromCoreData()
            completionHandler(true)
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    var getLeagues: ((FavoritesProtocol) -> Void)?
   
    //don't forget to change the model
    var LeaguesData: AllSports? {
        didSet{
            getLeagues!(self)
        }
    }
    
    
}

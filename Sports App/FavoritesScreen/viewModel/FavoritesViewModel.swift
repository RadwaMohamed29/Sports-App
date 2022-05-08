//
//  FavoritesViewModel.swift
//  Sports App
//
//  Created by Mohab El-Ziny on 05/05/2022.
//

import Foundation
import UIKit
import Reachability

protocol FavoritesProtocol {
    func callFuncToGetFavoriteLeagues(completionHandler:@escaping (Bool) -> Void) throws
    var getLeagues: ((FavoritesProtocol)->Void)? {get set}
    var LeaguesData: [Countrys]? {get set}
    func openYoutube(application:UIApplication, url:String)
    func callFuncToRemoveLeagueFromFavorites(leagueID:String, completionHandler:@escaping (Bool) -> Void) throws
    func callFuncToCheckInternetReachability(completionHandler:@escaping (Bool) -> Void)
}

final class FavoritesViewModel:FavoritesProtocol{
    let reachability = try! Reachability()
        
    private let localService:LocalService
    
    init(appDelegate:AppDelegate){
        localService = LocalSource(appDelegate: appDelegate)
    }
    
    func callFuncToGetFavoriteLeagues(completionHandler: @escaping (Bool) -> Void) throws {
        completionHandler(false)
        do{
            try LeaguesData = localService.getFavoriteLeguesDataFromCoreData()
            completionHandler(true)
        }catch let error{
            throw error
        }
    }
    
    var getLeagues: ((FavoritesProtocol) -> Void)?
   
    var LeaguesData: [Countrys]? 
     
    
    func openYoutube(application:UIApplication, url:String){
        if application.canOpenURL(URL(string: url)!) {
            application.open(URL(string: url)!)
        }else {
            application.open(URL(string: "https://\(url)")!)
        }
    }
    
    func callFuncToRemoveLeagueFromFavorites(leagueID: String, completionHandler: @escaping (Bool) -> Void) throws {
        completionHandler(false)
        do{
            try localService.removeLeagueFromCoreData(leagueID: leagueID)
            completionHandler(true)
        }catch let error{
            throw error
        }
    }
    
    func callFuncToCheckInternetReachability(completionHandler:@escaping (Bool) -> Void) {
        reachability.whenReachable = {_ in
            completionHandler(true)
        }
        reachability.whenUnreachable = {_ in
            completionHandler(false)
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}

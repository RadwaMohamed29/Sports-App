//
//  AllSportsViewModel.swift
//  Sports App
//
//  Created by mac hub on 03/05/2022.
//

import Foundation


protocol AllSportsProtocol {
    func callFuncToGetAllSports(completionHandler:@escaping (Bool) -> Void)
    var getSports: ((AllSportsProtocol)->Void)? {get set}
    var sportData: AllSports? {get set}
}

final class AllSportsViewModel: AllSportsProtocol {
    
//    func getLeaguesViewModel(for index: Int) -> LeaguesViewModel {
//        return LeaguesViewModel(sport: (sportData?.sports[index])!)
//    }
    
    
    var sportData: AllSports? {
        didSet {
            getSports!(self)
        }
    }
    
    
    let allSportsProvider: AllSportsProvider = APIClient()
    
    func callFuncToGetAllSports(completionHandler: @escaping (Bool) -> Void) {
        completionHandler(false)
        allSportsProvider.getAllSportsFromAPI { [weak self] result in
            switch result {
                
            case .success(let allSports):
                self?.sportData = allSports
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            completionHandler(true)
        }
    }
    
    var getSports: ((AllSportsProtocol) -> Void)?

    
    
}

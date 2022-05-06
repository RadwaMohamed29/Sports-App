//
//  EventsViewModel.swift
//  Sports App
//
//  Created by mac hub on 06/05/2022.
//

import Foundation

protocol EventsProtocol {
    func callFuncToGetEventsFromApi(completionHandler:@escaping (Bool) -> Void)
    var getEvents: ((EventsProtocol)->Void)? {get set}
    var eventsData: LastEvents? {get set}
    var selectedTeam: Team? {get set}
}

final class EventsViewModel: EventsProtocol {
    var selectedTeam: Team?
    
    let eventsProvider: EventsProvider = APIClient()
    
    func callFuncToGetEventsFromApi(completionHandler: @escaping (Bool) -> Void) {
        completionHandler(false)
        guard let selectedTeam = selectedTeam else {
            return
        }

        eventsProvider.getEventsFromApi(teamId: selectedTeam.teamID) { [weak self] result in
            switch result {
                
            case .success(let events):
                self?.eventsData = events
            case .failure(let error):
                print(error)
            }
        }
        completionHandler(true)
    }
    
    var getEvents: ((EventsProtocol) -> Void)?
    
    var eventsData: LastEvents? {
        didSet {
            getEvents!(self)
        }
    }
    
    
}

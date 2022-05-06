//
//  LocalService.swift
//  Sports App
//
//  Created by Mohab El-Ziny on 05/05/2022.
//

import Foundation
import CoreData

protocol LocalService{
    func saveLeagueToCoreData() throws
    func removeLeagueFromCoreData(leagueID:String) throws
    func getFavoriteLeguesDataFromCoreData() throws
}

final class LocalSource: LocalService{
    
    private var context:NSManagedObjectContext!
    private var entity:NSEntityDescription!
    
    init(appDelegate:AppDelegate){
        context = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "League", in: context)
    }

    func saveLeagueToCoreData() throws{
        let league = NSManagedObject(entity: entity, insertInto: context)
        league.setValue("idLeague", forKey: "idLeague")
        league.setValue("strBadge", forKey: "strBadge")
        league.setValue("strCountry", forKey: "strCountry")
        league.setValue("strLeague", forKey: "strLeague")
        league.setValue("strSport", forKey: "strSport")
        league.setValue("strYoutube", forKey: "strYoutube")
        
        do{
            try context.save()
        }catch let error as NSError{
           throw error
        }
    }
    
    func removeLeagueFromCoreData(leagueID:String) throws{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "League")
        let myPredicate = NSPredicate(format: "idLeague == %@", leagueID)
        fetchRequest.predicate = myPredicate
        do{
            let leagueList = try context.fetch(fetchRequest)
            for league in leagueList{
                context.delete(league)
            }
            try self.context.save()
        }catch let error as NSError{
            throw error
        }
    }
    
    func getFavoriteLeguesDataFromCoreData() throws{
//        let favoriteLeagues:[Leagues]
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "League")
        
        do{
            let LeaguesList = try context.fetch(fetchRequest)
            for favoriteLeague in LeaguesList{
                let idLeague:String = favoriteLeague.value(forKey:"idLeague") as? String ?? ""
                let strBadge:String = favoriteLeague.value(forKey:"strBadge") as? String ?? ""
                let strCountry:String = favoriteLeague.value(forKey:"strCountry") as? String ?? ""
                let strLeague:String = favoriteLeague.value(forKey:"strLeague") as? String ?? ""
                let strSport:String = favoriteLeague.value(forKey:"strSport") as? String ?? ""
                let strYoutube:String = favoriteLeague.value(forKey:"strYoutube") as? String ?? ""
                
//                favouriteLeagues.append(League)
            }
//            return favoriteLeagues
        }catch let error as NSError{
            throw error
        }
    }
    
}

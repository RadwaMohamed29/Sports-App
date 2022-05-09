//
//  LocalService.swift
//  Sports App
//
//  Created by Mohab El-Ziny on 05/05/2022.
//

import Foundation
import CoreData

protocol LocalService{
    func saveLeagueToCoreData(newLeague:Countrys) throws
    func removeLeagueFromCoreData(leagueID:String) throws
    func getFavoriteLeguesDataFromCoreData() throws -> [Countrys]
    func isFavouriteLeague(idLeague:String) throws -> Bool
   
}

final class LocalSource: LocalService{
 
    private var context:NSManagedObjectContext!
    private var entity:NSEntityDescription!
    
    init(appDelegate:AppDelegate){
        context = appDelegate.persistentContainer.viewContext
        entity = NSEntityDescription.entity(forEntityName: "League", in: context)
    }

    func saveLeagueToCoreData(newLeague:Countrys) throws{
        let league = NSManagedObject(entity: entity, insertInto: context)
        league.setValue(newLeague.idLeague, forKey: "idLeague")
        league.setValue(newLeague.strBadge, forKey: "strBadge")
        league.setValue(newLeague.strCountry, forKey: "strCountry")
        league.setValue(newLeague.strLeague, forKey: "strLeague")
        league.setValue(newLeague.strSport, forKey: "strSport")
        league.setValue(newLeague.strYoutube, forKey: "strYoutube")
        
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
    
    func getFavoriteLeguesDataFromCoreData() throws -> [Countrys]{
        var favoriteLeagues = [Countrys]()
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
                
                favoriteLeagues.append(Countrys(idLeague: idLeague, strSport: strSport, strLeague: strLeague, strCountry: strCountry, strYoutube: strYoutube, strBadge: strBadge))
            }
            return favoriteLeagues
        }catch let error as NSError{
            throw error
        }
    }
    
    func isFavouriteLeague(idLeague: String) throws -> Bool {
        do{
            let leagues = try self.getFavoriteLeguesDataFromCoreData()
            for item in leagues{
                if item.idLeague == idLeague {
                    return true
                }
            }
        }catch let error{
            throw error
        }
        return false
    }
    
//    func fetchData() -> [NSManagedObject]?{
//        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "League")
//        if let arr = try? context.fetch(fetchReq) {
//            if arr.count > 0 {
//                return arr
//            }
//           return nil
//        }else{
//            return nil
//        }
//    }
    
}

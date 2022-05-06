//
//  APIClient.swift
//  Sports App
//
//  Created by mac hub on 03/05/2022.
//

import Foundation


protocol AllSportsProvider {
    func getAllSportsFromAPI(completion: @escaping(Result<AllSports,APIError>) -> Void)
}

protocol CountriesProvider {
    func getCountriesFromApi(completion: @escaping(Result<Countries,APIError>) -> Void)

}

protocol LeaguesProvider {
    func getLeaguesFromAPI(strCountry:String ,strSport:String ,completion: @escaping (Result<Leagues, APIError>) -> Void)
}

protocol TeamsProvider {
    func getTeamsFromApi(strLeague: String,completion: @escaping (Result<Teams, APIError>) -> Void )
}

class APIClient: AllSportsProvider,CountriesProvider,LeaguesProvider , TeamsProvider {

    func getAllSportsFromAPI(completion: @escaping (Result<AllSports, APIError>) -> Void) {
        request(endPoint: .allSpors, method: .GET, completion: completion)
    }
    
    func getCountriesFromApi(completion: @escaping (Result<Countries, APIError>) -> Void) {
        request(endPoint: .countries, method: .GET, completion: completion)
    }
    
    func getLeaguesFromAPI(strCountry:String ,strSport:String ,completion: @escaping (Result<Leagues, APIError>) -> Void){
        request(endPoint: .searchAllLeagues(country: strCountry, sport: strSport) , method: .GET, completion: completion)
    }
    
    func getTeamsFromApi(strLeague: String, completion: @escaping (Result<Teams, APIError>) -> Void) {
        request(endPoint: .searchAllTeams(leagueStr: strLeague), method: .GET, completion: completion)
    }
    

    private let baseURL = "https://www.thesportsdb.com/api/v1/json/2"
    
    
    
    private func request<T:Codable>(endPoint: EndPoints, method: Methods, completion: @escaping((Result<T, APIError>) -> Void)) {
        let path = "\(baseURL)\(endPoint.path)"
        
        let urlString = path.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let urlString = urlString else {
            completion(.failure(.urlBadFormmated))
            return
        }

        guard let url = URL(string: urlString) else {
            completion(.failure(.internalError))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "\(method)"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        call(with: request, completion: completion)
    }
    
    private func call<T:Codable> (with request: URLRequest, completion: @escaping((Result<T, APIError>) -> Void)) {
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.serverError))
                return
            }
            
            do {
                guard let data = data else {
                    completion(.failure(.serverError))
                    return
                }
                let object = try JSONDecoder().decode(T.self , from: data)
                completion(Result.success(object))
            } catch {
                completion(Result.failure(.parsingError))
            }
            
        }
        dataTask.resume()
    }
    
}

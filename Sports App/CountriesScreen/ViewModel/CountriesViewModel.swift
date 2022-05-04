//
//  CountriesViewModel.swift
//  Sports App
//
//  Created by Mohab El-Ziny on 03/05/2022.
//

import Foundation

protocol CountriesProtocol {
    func callFuncToGetCountries(completionHandler:@escaping (Bool) -> Void)
    var getCountries: ((CountriesProtocol)->Void)? {get set}
    var countriesData: Countries? {get set}
}

final class CountiresViewModel:CountriesProtocol{
    
    var countriesData: Countries? {
        didSet {
            getCountries!(self)
        }
    }
    
    let countriesProvider: CountriesProvider = APIClient()

    func callFuncToGetCountries(completionHandler: @escaping (Bool) -> Void) {
        completionHandler(false)
        countriesProvider.getCountriesFromApi { [weak self] result in
            switch result {
            case .success(let countries):
                self?.countriesData = countries

            case .failure(let error):
                print(error.localizedDescription)
            }
            completionHandler(true)
        }
    }
    
    var getCountries: ((CountriesProtocol) -> Void)?
    
}

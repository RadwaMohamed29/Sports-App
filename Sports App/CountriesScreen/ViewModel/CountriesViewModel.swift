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
    var isChecked: Bool {get set}
    var selectedRow: Int {get set}
    func checkSelectedRow(indexPath: IndexPath)
    
}

final class CountiresViewModel: CountriesProtocol {
    

    
    var selectedRow: Int = -1
    
    
    var isChecked: Bool = false
    
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
    
    func toggle(cell: CountriesTableViewCell) {
        self.isChecked = !self.isChecked
        if self.isChecked {
            cell.checkMarkImage.isHidden = false
        }else {
            cell.checkMarkView.backgroundColor = .systemBackground
            cell.checkMarkImage.isHidden = true
        }
    }
    
    func checkSelectedRow(indexPath: IndexPath) {
        if(selectedRow == -1 ){
            selectedRow = indexPath.row
        }else{
            selectedRow = -1
        }
    }
    
}

//
//  CountriesViewController.swift
//  Sports App
//
//  Created by mac hub on 03/05/2022.
//

import UIKit
import KRProgressHUD

class CountriesViewController: UIViewController {
    
    var sportName:String?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredCountries: [Country] = []
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }


    var countriesViewModel: CountiresViewModel? {
        didSet{
            countriesViewModel?.callFuncToGetCountries(completionHandler: { (isFinished) in
                if !isFinished {
                    KRProgressHUD.show()
                }else {
                    KRProgressHUD.dismiss()
                }
            })
            
            countriesViewModel?.getCountries = {[weak self] _ in
                DispatchQueue.main.async {
                    self?.countriesTableView.reloadData()
                }
            }
        }
    }
    
    @IBOutlet weak var countriesTableView: UITableView! {
        didSet {
            countriesTableView.register(UINib(nibName: String(describing: CountriesTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CountriesTableViewCell.self))
            countriesTableView.delegate = self
            countriesTableView.dataSource = self
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countriesViewModel = CountiresViewModel()
        
        setupSearchController()
        
    }
    
    
    private func setupSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Countries"
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: UIColor.gray]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = attributes
       
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func filterContentForSearchText(_ searchText: String,
                                    category: Country? = nil) {
        filteredCountries = (countriesViewModel?.countriesData?.countries.filter { (country: Country) -> Bool in
            return country.countryName.lowercased().contains(searchText.lowercased())
        })!
      
      countriesTableView.reloadData()
    }

}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCountries.count
        }
        return countriesViewModel?.countriesData?.countries.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CountriesTableViewCell.self), for: indexPath) as? CountriesTableViewCell
        else {
            return UITableViewCell()
        }
        
        configureCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    func configureCell(cell: CountriesTableViewCell, indexPath: IndexPath) {
        
        let country: Country
        guard let countryFromViewModel =  countriesViewModel?.countriesData?.countries[indexPath.row] else {return}
        if isFiltering {
            country = filteredCountries[indexPath.row]
        }else {
            country = countryFromViewModel
        }
        
        cell.countryLabel.text = country.countryName
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? CountriesTableViewCell else {return}
        countriesViewModel?.toggle(cell: cell)
        tableView.deselectRow(at: indexPath, animated: true)
        countriesViewModel?.checkSelectedRow(indexPath: indexPath)
        selectedTeamFromArray(indexPath)
    }
    
    private func selectedTeamFromArray(_ indexPath: IndexPath) {
        let country: Country
        guard let countriesFromViewModel =  countriesViewModel?.countriesData?.countries else {return}
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let leaguesVC = storyboard.instantiateViewController(withIdentifier: "LeaguesViewController")
        as! LeaguesViewController
        
        if isFiltering {
            country = filteredCountries[indexPath.row]
        }else {
            country = countriesFromViewModel[indexPath.row]
        }
        leaguesVC.choice = Choices(sportName: sportName ?? "", countryName: country.countryName)
        self.navigationController?.pushViewController(leaguesVC, animated: true)
    }
}


extension CountriesViewController: UISearchResultsUpdating {
    
  func updateSearchResults(for searchController: UISearchController) {
      let searchBar = searchController.searchBar
      filterContentForSearchText(searchBar.text!)

  }
}





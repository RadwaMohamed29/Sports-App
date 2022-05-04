//
//  CountriesViewController.swift
//  Sports App
//
//  Created by mac hub on 03/05/2022.
//

import UIKit
import KRProgressHUD

class CountriesViewController: UIViewController {
    
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
        
    }
}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

        cell.countryLabel.text = countriesViewModel?.countriesData?.countries[indexPath.row].countryName
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let cell = tableView.cellForRow(at: indexPath) as? CountriesTableViewCell else {return}
        cell.toggle()
        tableView.deselectRow(at: indexPath, animated: true)
        createRightBarButtonItem()
        
        
    }
    
    private func createRightBarButtonItem() {
        let doneBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        self.navigationItem.rightBarButtonItem  = doneBarButtonItem
    }
    
    @objc func didTapDone() {
        
    }
    
}

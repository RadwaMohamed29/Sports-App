//
//  CountriesViewController.swift
//  Sports App
//
//  Created by mac hub on 03/05/2022.
//

import UIKit

class CountriesViewController: UIViewController {
    
    
    
    @IBOutlet weak var countriesTableView: UITableView! {
        didSet {
            countriesTableView.register(UINib(nibName: String(describing: CountriesTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: CountriesTableViewCell.self))
            countriesTableView.delegate = self
            countriesTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
    }
}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
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

        cell.countryLabel.text = "Egypt"
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

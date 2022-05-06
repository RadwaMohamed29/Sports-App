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
    
    var sportName:String?
    
    var selectedRow = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

       countriesViewModel = CountiresViewModel()
        
    }
    
    private func presentAlertView(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
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
        if(selectedRow == -1 || selectedRow == indexPath.row){
            guard let cell = tableView.cellForRow(at: indexPath) as? CountriesTableViewCell else {return}
            cell.toggle()
            tableView.deselectRow(at: indexPath, animated: true)
            createRightBarButtonItem()
            if(selectedRow == -1 ){
                selectedRow = indexPath.row
            }else{
                selectedRow = -1
            }
        }else{
            presentAlertView(title: "You already selected a country",message: "Deselect it if you want to change")
        }
    }
    
    private func createRightBarButtonItem() {
        let doneBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        self.navigationItem.rightBarButtonItem  = doneBarButtonItem
    }
    
    @objc func didTapDone() {
        if(selectedRow != -1){
            let choices = Choices(sportName: sportName ?? "nil", countryName: countriesViewModel?.countriesData?.countries[selectedRow].countryName ?? "nil")
            
        }else{
            presentAlertView(title: "Alert!",message: "You should select one country")
        }
    }
    
}

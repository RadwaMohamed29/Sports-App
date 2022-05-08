//
//  TeamsViewController.swift
//  Sports App
//
//  Created by mac hub on 06/05/2022.
//

import UIKit
import KRProgressHUD

class TeamsViewController: UIViewController {
    var selectedItems: SelectedItem?
    
    @IBOutlet weak var teamsTableView: UITableView! {
        didSet {
            teamsTableView.register(UINib(nibName: String(describing: TeamTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TeamTableViewCell.self))
            teamsTableView.dataSource = self
            teamsTableView.delegate = self
        }
    }
    
    var teamsViewModel: TeamsViewModel?{
        didSet{
            guard let selectedItems = selectedItems else {
                return
            }
            teamsViewModel?.checkFavouriteState(leagueId: selectedItems.countrys.idLeague)
            teamsViewModel?.selectedItems = selectedItems
            teamsViewModel?.callFuncToGetAllTeams(completionHandler: { (isFinshed) in
                if !isFinshed{
                    KRProgressHUD.show()
                }else {
                    KRProgressHUD.dismiss()
                }
            })
            
            teamsViewModel?.getTeams = {[weak self] _ in
                DispatchQueue.main.async {
                    self?.teamsTableView.reloadData()
                }
                
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        teamsViewModel = TeamsViewModel(appDelegate: appDelegate)
        self.setNavigationItem()
    }
    
}

extension TeamsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamsViewModel?.teamsData?.teams.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TeamTableViewCell.self), for: indexPath) as? TeamTableViewCell else {return UITableViewCell()}
        configureCell(cell, indexPath)
        
        return cell
    }
    
    private func configureCell(_ cell: TeamTableViewCell, _ indexPath: IndexPath) {
        let item = teamsViewModel?.teamsData?.teams[indexPath.row]
        guard let item = item else {return}
        cell.teamNameLabel.text = item.teamName
        guard let teamImage = item.teamImage else {return}
        let url = URL(string: teamImage)
        cell.teamLogoImageView.kf.setImage(with: url)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 105
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = DetailsLeagueViewController(nibName: String(describing: DetailsLeagueViewController.self), bundle: nil)
        detailsVC.selectedTeam = teamsViewModel?.teamsData?.teams[indexPath.row]
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    private func presentAlertView(message:String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func setNavigationItem() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "heart"), style: .plain, target: self, action: #selector(addTapped))
        guard let favState = teamsViewModel?.favouriteState else{return}
        if(favState){
            self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        }else{
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        }
        
    }
    
 
    @objc func addTapped() {
        teamsViewModel?.checkFavouriteState(leagueId: (selectedItems?.countrys.idLeague)!)
        guard let favState = teamsViewModel?.favouriteState else{return}
        if (favState) {
            do{
                try  teamsViewModel?.callFuncToRemoveLeagueFromFavorites(leagueID: selectedItems!.countrys.idLeague, completionHandler: {[weak self] (isFinished) in
                    if isFinished{
                        print("removed")
                        self!.navigationItem.rightBarButtonItem?.tintColor = UIColor.white
                    }
                })
            }catch let error{
                presentAlertView(message: error.localizedDescription)
            }
            
        }else{
            do{
                
                try  teamsViewModel?.saveLeagueToCoreData(newLeague: selectedItems!.countrys, completionHandler: {[weak self] (isFinished) in
                    if isFinished{
                        print("saved")
                        self!.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                    }
                })
            }catch let error{
                presentAlertView(message: error.localizedDescription)
            }
            
            
        }
    }
    
    
}

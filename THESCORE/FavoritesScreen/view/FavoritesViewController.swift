//
//  FavoritesViewController.swift
//  Sports App
//
//  Created by Mohab El-Ziny on 05/05/2022.
//

import UIKit
import KRProgressHUD

class FavoritesViewController: UITableViewController {
    
    private var favoritesViewModel:FavoritesProtocol? {
        didSet{
            
            favoritesViewModel?.getLeagues = {[weak self] _ in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        favoritesViewModel = FavoritesViewModel(appDelegate: appDelegate)
        self.callDataFromViewModel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "leagueTableViewCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesViewModel?.LeaguesData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "leagueTableViewCell", for:indexPath) as? LeagueTableViewCell
        else {
            return UITableViewCell()
        }
        configureCell(cell: cell, indexPath: indexPath)
        configureLeagueImage(leagueImage: cell.leagueImage)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == .delete){
            do{
                try favoritesViewModel?.callFuncToRemoveLeagueFromFavorites(leagueID: favoritesViewModel?.LeaguesData?[indexPath.row].idLeague ?? "nil", completionHandler: {[weak self] (isFinished) in
                    if isFinished{
                        self?.callDataFromViewModel()
                    }
                })
            }catch let error{
                presentAlertView(message: error.localizedDescription)
            }
        }
    }
    
    func configureLeagueImage(leagueImage: UIImageView) {
        leagueImage.layer.borderWidth = 1
        leagueImage.layer.masksToBounds = false
        leagueImage.layer.borderColor = UIColor.black.cgColor
        leagueImage.layer.cornerRadius = leagueImage.frame.height/2
        leagueImage.clipsToBounds = true
    }
    
    func configureCell(cell:LeagueTableViewCell, indexPath: IndexPath){
        let item = favoritesViewModel?.LeaguesData?[indexPath.row]
        guard let item = item else {
            return
        }
        cell.leagueName.text = item.strLeague
        print(item.strLeague)
        let url = URL(string: item.strBadge)
        cell.leagueImage.kf.setImage(with: url)
        cell.youtube.accessibilityValue = item.strYoutube
        if item.strYoutube == ""{
            cell.youtube.isEnabled = false
            cell.youtube.isHidden = true
        }else{
            cell.youtube.isEnabled = true
            cell.youtube.addTarget(self, action: #selector(self.youtubeOpened), for: .touchUpInside)
        }
    }
    
    @objc func youtubeOpened(sender:UIButton){
        let application = UIApplication.shared
        let url = sender.accessibilityValue!
        favoritesViewModel?.openYoutube(application: application, url: url)
    }
    
    private func presentAlertView(message:String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func callDataFromViewModel(){
        do{
            try favoritesViewModel?.callFuncToGetFavoriteLeagues(completionHandler: {(isFinished) in
                if !isFinished{
                    KRProgressHUD.show()
                }else{
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                    KRProgressHUD.dismiss()
                }
            })
        }catch let error{
            presentAlertView(message: error.localizedDescription)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        favoritesViewModel?.callFuncToCheckInternetReachability(completionHandler: {[weak self] (isReachable) in
            if(isReachable){
                guard let league = self?.favoritesViewModel?.LeaguesData?[indexPath.row] else {return}
                
                let selectedItems = SelectedItem(sportName: league.strSport, countryName: league.strCountry, leagueName: (league.strLeague),countrys: league)
                let teamsVC = TeamsViewController(nibName: String(describing: TeamsViewController.self), bundle: nil)
                teamsVC.selectedItems = selectedItems
                self?.navigationController?.pushViewController(teamsVC, animated: true)
            }else{
                self?.presentAlertView(message: "There is no internet connection")
            }
        })
    }
}

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
            favoritesViewModel?.callFuncToGetFavoriteLeagues(completionHandler: {(isFinished) in
                if !isFinished{
                    KRProgressHUD.show()
                }else{
                    KRProgressHUD.dismiss()
                }
            })
            
            favoritesViewModel?.getLeagues = {[weak self] _ in
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        favoritesViewModel = FavoritesViewModel(appDelegate: appDelegate)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesViewModel?.LeaguesData?.sports.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "leagueTableViewCell", for:indexPath) as? LeagueTableViewCell
        else {
            return UITableViewCell()
        }
        configureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func configureCell(cell: LeagueTableViewCell, indexPath: IndexPath) {
        cell.leagueImage.layer.borderWidth = 1
        cell.leagueImage.layer.masksToBounds = false
        cell.leagueImage.layer.borderColor = UIColor.black.cgColor
        cell.leagueImage.layer.cornerRadius = cell.leagueImage.frame.height/2
        cell.leagueImage.clipsToBounds = true
    }

}

//
//  LeaguesViewController.swift
//  Sports App
//
//  Created by Radwa on 29/04/2022.
//

import UIKit
import KRProgressHUD


class LeaguesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var leaguesViewModel: LeaguesViewModel?{
        didSet{
            guard let choice = choice else{return}
            leaguesViewModel?.choice = choice
            leaguesViewModel?.callFuncToGetAllLeagues(completionHandler: { (isFinshed) in
                if !isFinshed{
                    KRProgressHUD.show()
                }else {
                    KRProgressHUD.dismiss()
                }
            })
            
            leaguesViewModel?.getLeagues = {[weak self] _ in
                DispatchQueue.main.async {
                    self?.leaguesTableView.reloadData()
                }
                
            }
            
        }
    }
    
    @objc func youtubeOpened(sender:UIButton){
        let url = sender.accessibilityValue!
        leaguesViewModel?.openYoutube(url: url)
    }
    
    @IBOutlet weak var leaguesTableView: UITableView!{
        didSet{
            leaguesTableView.dataSource = self
            leaguesTableView.delegate = self
            self.leaguesTableView.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "leagueTableViewCell")
            
        }
    }
    
    var choice: Choices?
    override func viewDidLoad() {
        super.viewDidLoad()
        leaguesViewModel =  LeaguesViewModel()
        print(choice?.sportName )
        print(choice?.countryName)

        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Leagues"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesViewModel?.leagueData?.countrys.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = leaguesTableView.dequeueReusableCell(withIdentifier: "leagueTableViewCell", for:indexPath) as? LeagueTableViewCell   else{fatalError()}
        setUpCell(with: cell, indexPath: indexPath)
        configureCell(cell: cell, indexPath: indexPath)
        
        return cell
        
        
    }
    
    func configureCell(cell:LeagueTableViewCell, indexPath: IndexPath){
        let item = leaguesViewModel?.leagueData?.countrys[indexPath.row]
        guard let item = item else {
            return
        }
        cell.leagueName.text = item.strLeague
        let url = URL(string: item.strBadge)
        cell.leagueImage.kf.setImage(with: url)
        cell.youtube.accessibilityValue = item.strYoutube
        if item.strYoutube == ""{
            cell.youtube.isEnabled = false
            cell.youtube.isHidden = true
        }else{
            cell.youtube.isEnabled = true
        }
        
        cell.youtube.addTarget(self, action: #selector(self.youtubeOpened), for: .touchUpInside)
    }
    
    func setUpCell(with cell: LeagueTableViewCell, indexPath: IndexPath){
        cell.leagueImage.layer.borderWidth = 1
        cell.leagueImage.layer.masksToBounds = false
        cell.leagueImage.layer.borderColor = UIColor.black.cgColor
        cell.leagueImage.layer.cornerRadius = cell.leagueImage.frame.height/2
        cell.leagueImage.clipsToBounds = true
        
    }
    
}

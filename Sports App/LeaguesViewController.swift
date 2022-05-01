//
//  LeaguesViewController.swift
//  Sports App
//
//  Created by Radwa on 29/04/2022.
//

import UIKit

class LeaguesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var leaguesTableView: UITableView!{
        didSet{
            leaguesTableView.dataSource = self
            leaguesTableView.delegate = self
            self.leaguesTableView.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "leagueTableViewCell")
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Leagues"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = leaguesTableView.dequeueReusableCell(withIdentifier: "leagueTableViewCell", for:indexPath) as? LeagueTableViewCell   else{fatalError()}
        setUpCell(with: cell, indexPath: indexPath)
        
        return cell
        
        
    }
    
    func setUpCell(with cell: LeagueTableViewCell, indexPath: IndexPath){
        cell.leagueImage.layer.borderWidth = 1
        cell.leagueImage.layer.masksToBounds = false
        cell.leagueImage.layer.borderColor = UIColor.black.cgColor
        cell.leagueImage.layer.cornerRadius = cell.leagueImage.frame.height/2
        cell.leagueImage.clipsToBounds = true
        
    }
    
}

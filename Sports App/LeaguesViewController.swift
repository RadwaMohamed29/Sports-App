//
//  LeaguesViewController.swift
//  Sports App
//
//  Created by Radwa on 29/04/2022.
//

import UIKit

class LeaguesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tbView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tbView.delegate=self
        tbView.dataSource=self
        self.tbView.register(UINib(nibName: "LeagueTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        

        
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
        let cell = tbView.dequeueReusableCell(withIdentifier: "cell", for:indexPath) as! LeagueTableViewCell
        cell.leagueImage.layer.borderWidth = 1
        cell.leagueImage.layer.masksToBounds = false
        cell.leagueImage.layer.borderColor = UIColor.black.cgColor
        cell.leagueImage.layer.cornerRadius = cell.leagueImage.frame.height/2
        cell.leagueImage.clipsToBounds = true
        return cell
    }
    


}

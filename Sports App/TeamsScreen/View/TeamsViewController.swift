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
        teamsViewModel = TeamsViewModel()
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
    
    
}

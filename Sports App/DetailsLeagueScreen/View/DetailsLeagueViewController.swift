//
//  DetailsLeagueViewController.swift
//  Sports App
//
//  Created by mac hub on 05/05/2022.
//

import UIKit
import KRProgressHUD

class DetailsLeagueViewController: UIViewController {
    var selectedTeam: Team?
    
    @IBOutlet weak var leagueDetailsTableView: UITableView! {
        didSet {
            leagueDetailsTableView.register(UINib(nibName: String(describing: TeamImageTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TeamImageTableViewCell.self))
            leagueDetailsTableView.register(UINib(nibName: String(describing: UpComingEventsTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: UpComingEventsTableViewCell.self))
            leagueDetailsTableView.register(UINib(nibName: String(describing: LatestEventsTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: LatestEventsTableViewCell.self))
            leagueDetailsTableView.dataSource = self
            leagueDetailsTableView.delegate = self
        }
    }
    
    var eventsViewModel: EventsViewModel?{
        didSet{
            guard let selectedTeam = selectedTeam else {
                return
            }
            eventsViewModel?.selectedTeam = selectedTeam
            eventsViewModel?.callFuncToGetEventsFromApi(completionHandler: { (isFinshed) in
                if !isFinshed{
                    KRProgressHUD.show()
                }else {
                    KRProgressHUD.dismiss()
                }
            })
            
            eventsViewModel?.getEvents = {[weak self] _ in
                DispatchQueue.main.async {
                    self?.leagueDetailsTableView.reloadData()
                }
                
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsViewModel = EventsViewModel()
       
    }
    
}

extension DetailsLeagueViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let teamImageCell = tableView.dequeueReusableCell(withIdentifier: String(describing: TeamImageTableViewCell.self), for: indexPath) as? TeamImageTableViewCell else { return UITableViewCell()}
            setUpTeamImageCell(teamImageCell, indexPath)
            return teamImageCell
        case 1:
            guard let upComingCell = tableView.dequeueReusableCell(withIdentifier: String(describing: UpComingEventsTableViewCell.self), for: indexPath) as? UpComingEventsTableViewCell else { return UITableViewCell()}
            upComingCell.upComingEventsViewModel = self.eventsViewModel
            return upComingCell
        case 2:
            guard let latestEventsCell = tableView.dequeueReusableCell(withIdentifier: String(describing: LatestEventsTableViewCell.self), for: indexPath) as? LatestEventsTableViewCell else { return UITableViewCell()}
            latestEventsCell.latestEventsViewModel = self.eventsViewModel
            return latestEventsCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            let teamDetails = TeamDetailsViewController(nibName: String(describing: TeamDetailsViewController.self), bundle: nil)
            teamDetails.selectedTeam = self.selectedTeam
            self.navigationController?.pushViewController(teamDetails, animated: true)
        default:
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 200
        case 1:
            return 300
        case 2:
            return 300

        default:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return ""
        case 1:
            return "Upcoming events"
        case 2:
            return "Latest events"
        default:
            return ""
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 45
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.backgroundConfiguration?.backgroundColor = UIColor.black
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
       
        header.textLabel?.frame = header.bounds
        header.textLabel?.textAlignment = .center
    }
    
    private func setUpTeamImageCell(_ cell: TeamImageTableViewCell, _ indexPath: IndexPath) {
        guard let selectedTeam = selectedTeam else {return}
        guard let teamImage = selectedTeam.teamImage else {return}
        let url = URL(string: teamImage)
        cell.teamImageView.kf.setImage(with: url)
    }
    
  
    
}

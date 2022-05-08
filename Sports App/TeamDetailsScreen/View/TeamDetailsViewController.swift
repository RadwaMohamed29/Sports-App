//
//  TeamDetailsViewController.swift
//  Sports App
//
//  Created by mac hub on 06/05/2022.
//

import UIKit

class TeamDetailsViewController: UIViewController {
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var stadiumImageView: UIImageView!
    
    @IBOutlet weak var teamBadgeImageView: UIImageView!
    
    @IBOutlet weak var teamNameLabel: UILabel!
    
    @IBOutlet weak var leagueNameLabel: UILabel!
    
    @IBOutlet weak var countryNameLabel: UILabel!
    
    @IBOutlet weak var foundedYearLabel: UILabel!
    
    
    @IBOutlet weak var stadiumNameLabel: UILabel!
    
    @IBOutlet weak var facebookLinkLabel: UILabel!
    
    @IBOutlet weak var descriptionEnLabel: UILabel!
    
    
    @IBOutlet weak var websiteLabel: UILabel!
    
    @IBOutlet weak var instgramLinkLabel: UILabel!
    
    @IBOutlet weak var twitterLinkLabel: UILabel!
    
    var selectedTeam: Team?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        handelGestureTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        
    }
    @objc func websiteOpened(sender:UITapGestureRecognizer){
        guard let url = (sender.view as? UILabel)?.text else { return }
        openWebsite(url: url)
        
    }
  
    func handelGestureTap(){
        let webSiteTapGesture = UITapGestureRecognizer(target: self, action: #selector(websiteOpened))
        let facebookTapGesture = UITapGestureRecognizer(target: self, action: #selector(websiteOpened))
        let twitterTapGesture = UITapGestureRecognizer(target: self, action: #selector(websiteOpened))
        let instgramTapGesture = UITapGestureRecognizer(target: self, action: #selector(websiteOpened))
 
        websiteLabel.addGestureRecognizer(webSiteTapGesture)
        websiteLabel.isUserInteractionEnabled=true
        
        facebookLinkLabel.addGestureRecognizer(facebookTapGesture)
        facebookLinkLabel.isUserInteractionEnabled=true
        
        instgramLinkLabel.addGestureRecognizer(instgramTapGesture)
        instgramLinkLabel.isUserInteractionEnabled=true

        twitterLinkLabel.addGestureRecognizer(twitterTapGesture)
        twitterLinkLabel.isUserInteractionEnabled=true
    }
    
    private func setupView() {
        guard let selectedTeam = selectedTeam else {
            return
        }
        guard let teamImage = selectedTeam.teamImage else {return}
        guard let backgroundImagee = selectedTeam.backgroundImage else {return}
        guard let stadiumImage = selectedTeam.stadiumImage else {return}
        
        
        let teamImageUrl = URL(string: teamImage)
        teamBadgeImageView.kf.setImage(with: teamImageUrl)
        
        let backgroundImageUrl = URL(string: backgroundImagee)
        backgroundImage.kf.setImage(with: backgroundImageUrl)
        
        let stadiumImageUrl = URL(string: stadiumImage)
        stadiumImageView.kf.setImage(with: stadiumImageUrl)
        
        descriptionEnLabel.text = selectedTeam.teamDiscription
        teamNameLabel.text = selectedTeam.teamName
        leagueNameLabel.text = selectedTeam.teamLeague
        countryNameLabel.text = selectedTeam.countryName
        foundedYearLabel.text = selectedTeam.teamFoundedDate
        stadiumNameLabel.text = selectedTeam.stadiumName
        facebookLinkLabel.text = selectedTeam.teamFacebook
        websiteLabel.text = selectedTeam.teamWebSite
        instgramLinkLabel.text = selectedTeam.teamInstagram
        twitterLinkLabel.text = selectedTeam.teamTwitter
        
       
    }
    func openWebsite(url:String){
        let application = UIApplication.shared
        if application.canOpenURL(URL(string: url)!) {
            application.open(URL(string: url)!)
        }else {
            application.open(URL(string: "https://\(url)")!)
        }
    }

}

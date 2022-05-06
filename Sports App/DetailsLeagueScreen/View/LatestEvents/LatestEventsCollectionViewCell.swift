//
//  LatestEventsCollectionViewCell.swift
//  Sports App
//
//  Created by mac hub on 05/05/2022.
//

import UIKit

class LatestEventsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerViewForEventImage: UIView!
    @IBOutlet weak var homeTeamLabel: UILabel!
    
    @IBOutlet weak var awayTeamLabel: UILabel!
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var homeTeamScoreLabel: UILabel!
    
    
    @IBOutlet weak var awayTeamScoreLabel: UILabel!
    
    @IBOutlet weak var eventImage: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    private func configureCell() {
        self.contentView.layer.borderWidth = 2
        self.contentView.layer.borderColor = UIColor.gray.cgColor.copy(alpha: 0.5)
        self.contentView.layer.cornerRadius = 10
        eventImage.clipsToBounds = true
        eventImage.layer.cornerRadius = 10
        
        
    }

}

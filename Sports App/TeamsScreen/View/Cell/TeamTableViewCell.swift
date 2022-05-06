//
//  TeamTableViewCell.swift
//  Sports App
//
//  Created by mac hub on 06/05/2022.
//

import UIKit

class TeamTableViewCell: UITableViewCell {

    @IBOutlet weak var teamNameLabel: UILabel!
    
    @IBOutlet weak var teamLogoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        teamLogoImageView.clipsToBounds = true
        teamLogoImageView.layer.borderWidth = 2
        teamLogoImageView.layer.cornerRadius = teamLogoImageView.frame.size.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

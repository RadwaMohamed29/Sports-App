//
//  LeagueTableViewCell.swift
//  Sports App
//
//  Created by Radwa on 29/04/2022.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var youtube: UIButton!
    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var view: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

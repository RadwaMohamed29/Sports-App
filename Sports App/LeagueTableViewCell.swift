//
//  LeagueTableViewCell.swift
//  Sports App
//
//  Created by Radwa on 27/04/2022.
//

import UIKit

class LeagueTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var sportImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func youtubeBtn(_ sender: Any) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

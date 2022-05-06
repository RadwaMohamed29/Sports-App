//
//  TeamImageTableViewCell.swift
//  Sports App
//
//  Created by mac hub on 05/05/2022.
//

import UIKit

class TeamImageTableViewCell: UITableViewCell {

    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var moreInfoButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        moreInfoButton.layer.borderColor = UIColor.gray.cgColor
        moreInfoButton.tintColor = UIColor.white
        moreInfoButton.titleLabel?.textColor = UIColor.gray
        moreInfoButton.layer.cornerRadius = 12
        moreInfoButton.imageView?.tintColor = UIColor.gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

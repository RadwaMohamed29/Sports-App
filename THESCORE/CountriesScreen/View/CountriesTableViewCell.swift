//
//  CountriesTableViewCell.swift
//  Sports App
//
//  Created by mac hub on 03/05/2022.
//

import UIKit

class CountriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var checkMarkView: UIView!
    @IBOutlet weak var checkMarkImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkMarkView.layer.borderWidth = 0.5
        checkMarkView.layer.borderColor = UIColor.secondaryLabel.cgColor
        checkMarkView.layer.cornerRadius = checkMarkView.frame.size.width / 2.0
        checkMarkView.backgroundColor = .systemBackground
        checkMarkView.isUserInteractionEnabled = true
        checkMarkImage.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

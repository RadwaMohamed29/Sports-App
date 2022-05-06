//
//  UpComingEventsCollectionViewCell.swift
//  Sports App
//
//  Created by mac hub on 05/05/2022.
//

import UIKit

class UpComingEventsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerViewForImage: UIView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var eventImage: UIImageView!
    
    @IBOutlet weak var hourLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    private func configureCell() {
        self.contentView.layer.borderWidth = 2
        self.contentView.layer.borderColor = UIColor.gray.cgColor.copy(alpha: 0.5)
        self.contentView.layer.cornerRadius = 10
        containerViewForImage.layer.cornerRadius = 10
        eventImage.layer.cornerRadius = 10
        eventImage.clipsToBounds = true
    }

}

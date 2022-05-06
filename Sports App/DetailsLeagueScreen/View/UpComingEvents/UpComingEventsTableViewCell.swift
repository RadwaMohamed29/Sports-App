//
//  UpComingEventsTableViewCell.swift
//  Sports App
//
//  Created by mac hub on 05/05/2022.
//

import UIKit

class UpComingEventsTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var upComingCollectionView: UICollectionView! {
        didSet {
            upComingCollectionView.register(UINib(nibName: String(describing: UpComingEventsCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: UpComingEventsCollectionViewCell.self))
            upComingCollectionView.dataSource = self
            upComingCollectionView.delegate = self
        }
    }
    
    var upComingEventsViewModel: EventsViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.upComingCollectionView.reloadData()
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UpComingEventsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upComingEventsViewModel?.eventsData?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: UpComingEventsCollectionViewCell.self), for: indexPath) as? UpComingEventsCollectionViewCell else {return UICollectionViewCell()}
        setUpUpcomingEventsCell(cell, indexPath)
        return cell
    }
    
    private func setUpUpcomingEventsCell(_ cell: UpComingEventsCollectionViewCell, _ indexPath: IndexPath) {
        let item = upComingEventsViewModel?.eventsData?.results[indexPath.row]
        guard let item = item else {return}
        
        cell.eventNameLabel.text = item.teamVsTeam
        cell.dateLabel.text = item.eventDate
        cell.hourLabel.text = item.eventTime
        guard let image = item.eventImage else {return}
        let url = URL(string: image)
        cell.eventImage.kf.setImage(with: url)
    }
    
    
    
    
    
    
}

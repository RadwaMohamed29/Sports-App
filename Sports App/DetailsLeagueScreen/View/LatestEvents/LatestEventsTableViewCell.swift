//
//  LatestEventsTableViewCell.swift
//  Sports App
//
//  Created by mac hub on 05/05/2022.
//

import UIKit

class LatestEventsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var latestCollectionView: UICollectionView! {
        didSet {
            latestCollectionView.register(UINib(nibName: String(describing: LatestEventsCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: LatestEventsCollectionViewCell.self))
            latestCollectionView.dataSource = self
            latestCollectionView.delegate = self
        }
    }
    
    var latestEventsViewModel: EventsViewModel? {
        didSet {
            DispatchQueue.main.async {
                self.latestCollectionView.reloadData()
            }
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension LatestEventsTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return latestEventsViewModel?.eventsData?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: LatestEventsCollectionViewCell.self), for: indexPath) as? LatestEventsCollectionViewCell else {return UICollectionViewCell()}
        setUpLatestEventsCell(cell, indexPath)
        return cell
    }
    
    private func setUpLatestEventsCell(_ cell: LatestEventsCollectionViewCell, _ indexPath: IndexPath) {
        let item = latestEventsViewModel?.eventsData?.results[indexPath.row]
        guard let item = item else {return}
        cell.homeTeamLabel.text = item.homeTeamName
        cell.awayTeamLabel.text = item.awayTeamName
        cell.homeTeamScoreLabel.text = item.homeTeamScore
        cell.awayTeamScoreLabel.text = item.awayTeamScore
        cell.dateLabel.text = item.eventDate
        guard let image = item.eventImage else {return}
        let url = URL(string: image)
        cell.eventImage.kf.setImage(with: url)
    }
    
}

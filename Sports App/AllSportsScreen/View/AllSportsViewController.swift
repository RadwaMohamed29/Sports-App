//
//  HomeCollectionViewController.swift
//  Sports App
//
//  Created by Mohab El-Ziny on 26/04/2022.
//

import UIKit
import Kingfisher
import KRProgressHUD

private let reuseIdentifier = "AllSportsCollectionViewCell"


class AllSportsViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    var sportsViewModel: AllSportsViewModel? {
        didSet {
            sportsViewModel?.callFuncToGetAllSports(completionHandler: {(isFinished) in
                if !isFinished {
                    KRProgressHUD.show()
                }else {
                    KRProgressHUD.dismiss()
                }
                
            })
            sportsViewModel?.getSports = {[weak self] vm in
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Register cell classes
        self.collectionView.register(UINib(nibName: "AllSportsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.sportsViewModel = AllSportsViewModel()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsViewModel?.sportData?.sports.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: AllSportsCollectionViewCell.self), for: indexPath) as? AllSportsCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        setupCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    private func setupCell(cell: AllSportsCollectionViewCell , indexPath: IndexPath) {
        let item = sportsViewModel?.sportData?.sports[indexPath.row]
        guard let item = item else {
            return
        }
        cell.homeCellLabel.text = item.sportName
        let url = URL(string: item.sportImage)
        cell.homeCellImage.kf.setImage(with: url)
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let countriesVC = CountriesViewController(nibName: String(describing: CountriesViewController.self), bundle: nil)
        countriesVC.sportName = sportsViewModel?.sportData?.sports[indexPath.row].sportName
        self.navigationController?.pushViewController(countriesVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = (view.frame.size.width - 4.0 )/2
        return CGSize(width: side, height: side)
    }

}

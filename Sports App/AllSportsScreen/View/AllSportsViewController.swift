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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView.register(UINib(nibName: "AllSportsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.sportsViewModel = AllSportsViewModel()

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
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
        self.navigationController?.pushViewController(countriesVC, animated: true)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = (view.frame.size.width - 16.0 )/2
        return CGSize(width: side, height: side)
    }

}

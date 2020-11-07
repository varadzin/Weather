//
//  WTFavoritesVC.swift
//  Weather
//
//  Created by Frantisek Varadzin on 01/11/2020.
//

import UIKit

class WTFavoritesVC: UIViewController {
    
    enum Section {
        case main
        
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    override func viewDidLoad() {
        super.viewDidLoad()
       configureCollectionView()

        navigationController?.navigationBar.prefersLargeTitles = true

    }

    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemPink
        collectionView.register(WTCell.self, forCellWithReuseIdentifier: WTCell.reuseID)
        
    }


    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
         
        return flowLayout
    }
    

    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WTCell.reuseID, for: indexPath) as! WTCell
            cell.set(follower: follower)
            return cell


        })
        
        
        
    }
    
func updateData() {
    var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
    snapshot.appendSections([.main])
    snapshot.appendItems([.init(weatherIcon: "10d", favoriteCitys: "Tokio")])
    DispatchQueue.main.async {
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    
    
    
    
    
    
}
}

//
//  WTFavoritesVC.swift
//  Weather
//
//  Created by Frantisek Varadzin on 01/11/2020.
//

import UIKit

class WTFavoritesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var favoritesArray = ["Kosice", "Presov"]
    var cityToFavoritesValue: String!
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesArray.append(cityToFavoritesValue)
//        print(favoritesArray)
        configureCollectionView()

        let defaults = UserDefaults.standard
        let citiesArray = favoritesArray
        defaults.set(citiesArray, forKey: "SavedArray")
        let savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        print(savedArray)
        print(citiesArray)
    }
    
    
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        
        layout.itemSize = CGSize(width: (view.frame.size.width/3)-4,
                                 height: (view.frame.size.width/3)-4)
        
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.backgroundColor = .systemBackground
        
        
        
        guard let collectionView = collectionView else {
            return
        }
        collectionView.register(WTCell.self, forCellWithReuseIdentifier: WTCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView.frame = view.bounds
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WTCell.identifier, for: indexPath) as! WTCell
        
        cell.configureCellLabel(label: "Mesto \(indexPath.row)")
        
        return cell
    }
    
   

        
        
    }
    














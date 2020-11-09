//
//  WTFavoritesVC.swift
//  Weather
//
//  Created by Frantisek Varadzin on 01/11/2020.
//

import UIKit

class WTFavoritesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
  
    var cityToFavoritesValue: String!
    var favoritesArray2 : [String] = []
    var clearButton = WTSearchBTN(backgroundColor: .red, title: "Clear", titleColor: .white)
    let defaults = UserDefaults.standard
    
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureClearButton()

    
        let citiesArray = favoritesArray2
        defaults.set(citiesArray, forKey: "SavedArray")


        print(favoritesArray2)
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
    
   
    func configureClearButton() {
        view.addSubview(clearButton)
        
        clearButton.addTarget(self, action: #selector(clearBtnPressed), for: .touchUpInside)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            clearButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clearButton.widthAnchor.constraint(equalToConstant: 150)
        
        ])
          
    }
        
    @objc func clearBtnPressed() {
        favoritesArray2.removeAll()
        defaults.removeObject(forKey: "SavedArray")
        let searchVC = WTSearchVC()
        searchVC.favoritesArray = favoritesArray2
        
        
    }
    }
    














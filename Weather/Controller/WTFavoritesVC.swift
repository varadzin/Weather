//
//  WTFavoritesVC.swift
//  Weather
//
//  Created by Frantisek Varadzin on 01/11/2020.
//

import UIKit

class WTFavoritesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
  
  
 
   var weatherImage = UIImageView()
    var temperature = String()
    var clearButton = WTSearchBTN(backgroundColor: .red, title: "Clear", titleColor: .white)
    let defaults = UserDefaults.standard
    var savedArray : [String] = []
    var savedTempArray : [String] = []
    var savedIconArray : [String] = []
    
    private var collectionView: UICollectionView?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        savedTempArray = defaults.object(forKey: "SavedTempArray") as? [String] ?? [String]()
        savedIconArray = defaults.object(forKey: "SavedIconArray") as? [String] ?? [String]()
        print(savedArray)
       
        
       
  
        configureCollectionView()
       
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
       
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
        return savedArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WTCell.identifier, for: indexPath) as! WTCell

        cell.configureCellLabel(label: savedArray[indexPath.row])
        cell.configureTempLabel(tempLabel: savedTempArray[indexPath.row])
        cell.configureWeatherImage(imageView: (UIImage(named: savedIconArray[indexPath.row])!))
   

        
        
        return cell
    }
    
   
   
}
  
    

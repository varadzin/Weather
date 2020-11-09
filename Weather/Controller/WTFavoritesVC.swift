//
//  WTFavoritesVC.swift
//  Weather
//
//  Created by Frantisek Varadzin on 01/11/2020.
//

import UIKit

class WTFavoritesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
  
    var cityToFavoritesValue: String!
    var weatherManager = WTManager()
   var weatherImage = UIImageView()
    var temperature = "24C"
    var clearButton = WTSearchBTN(backgroundColor: .red, title: "Clear", titleColor: .white)
    let defaults = UserDefaults.standard
    var savedArray : [String] = []
    
    private var collectionView: UICollectionView?
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
   
       print(savedArray)
        if let city = cityToFavoritesValue {
            weatherManager.fetchWeather(cityName: city)
        }
        
        configureCollectionView()

       
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
        cell.configureTempLabel(tempLabel: temperature)
        
        return cell
    }
    
   
   
}
  
    
//MARK: - WTManagerDelegate

extension WTFavoritesVC: WTManagerDelegate {
    func didUpdateWeather(_ weatherManager: WTManager, weather: WTModel) {
        DispatchQueue.main.async {
            self.weatherImage.image = UIImage(named: weather.weatherIcon)
//            self.temperature = "\(weather.temperatureString)°C"


        }
    }

    func didFailWithError(error: Error) {
        print(error)
    }
}


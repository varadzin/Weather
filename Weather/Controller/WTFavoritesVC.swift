//
//  WTFavoritesVC.swift
//  Weather
//
//  Created by Frantisek Varadzin on 01/11/2020.
//

import UIKit


class WTFavoritesVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {
    
    
    
    var collectionView: UICollectionView?
    var weatherManager = WTManager()
    
    //Arrays
    var savedArray : [String] = []
    var savedTempArray : [String] = []
    var savedIconArray : [String] = []
    var citiesToRefresh : [String] = []
    
    //Variables - used in Network Manager
    var weatherImage = UIImageView()
    var temperature = String()
    var cityName = String()
    var cityName2 = String()
    var icon = String()
    
    let defaults = UserDefaults.standard
    let dispatchGroup = DispatchGroup()
    var favoritesIsEmpty = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        clearBarButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        savedFavorites()
    }
    
    //MARK: - Data Exchange between SearchVC and FavoritesVC
    
    func savedFavorites() {
        savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        citiesToRefresh = savedArray
        savedTempArray = defaults.object(forKey: "SavedTempArray") as? [String] ?? [String]()
        savedIconArray = defaults.object(forKey: "SavedIconArray") as? [String] ?? [String]()
        configureCollectionView()
    }
    
    //MARK: UICollectionView
    func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.itemSize = CGSize(width: (view.frame.size.width/3)-4, height: (view.frame.size.width/3)-4)
        
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
        
        //refresh
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return citiesToRefresh.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WTCell.identifier, for: indexPath) as! WTCell
        
        //if API download slowly APP doenst crash
        if citiesToRefresh.count == savedArray.count && citiesToRefresh.count == savedTempArray.count {
            
            //Here happens THE MAGIC
            cell.configureCellLabel(label: savedArray[indexPath.row])
            cell.configureTempLabel(tempLabel: savedTempArray[indexPath.row])
            cell.configureWeatherImage(imageView: (UIImage(named: savedIconArray[indexPath.row])!))
        }
        return cell
    }
    
    //MARK: - Updating the Values
    @objc func didPullToRefresh() {
        //re-fetch data
        print("start refreshing")
        
        DispatchQueue.main.async {
            self.collectionView?.refreshControl?.endRefreshing()
            self.fetchAllValues()
        }
    }
    
    func fetchAllValues() {
        
        print(citiesToRefresh)
        savedArray.removeAll()
        savedTempArray.removeAll()
        savedIconArray.removeAll()
        
        for value in citiesToRefresh {
            weatherManager.fetchWeather(cityName: value)
        }
        self.reloadCV()
    }
    
    func reloadCV() {
        run(after: 1) {
            if self.savedArray.count == self.savedTempArray.count {
                self.collectionView?.reloadData()
            } else {
                print("Error: not enough data")
            }
        }
        
    }
    
    func run(after seconds: Int, completion: @escaping () -> Void) {
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
    }
    
    
    //MARK: - Delete Favorites Cities
    func clearBarButton() {
        let clearButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearFavorites))
        self.navigationItem.rightBarButtonItem = clearButton
    }
    
    func alertWindow(title: String, message: String) {
        let refreshAlert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.eraseAllFavorites()
            self.didPullToRefresh()
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        present(refreshAlert, animated: true, completion: nil)
    }
    
    func eraseAllFavorites() {
        self.citiesToRefresh.removeAll()
        self.defaults.removeObject(forKey: "SavedArray")
        self.defaults.removeObject(forKey: "SavedTempArray")
        self.defaults.removeObject(forKey: "SavedIconArray")
        self.favoritesIsEmpty = true
        self.defaults.set(self.favoritesIsEmpty, forKey: "FavoritesDeleted")
    }
    
    @objc func clearFavorites() {
        alertWindow(title: "Delete", message: "Delete all favorites Cities, are You sure?")
    }
}

//MARK: - WTManagerDelegate - Downloading the values
extension WTFavoritesVC: WTManagerDelegate {
    func didUpdateWeather(_ weatherManager: WTManager, weather: WTModel) {
        DispatchQueue.main.async {
            self.temperature = "\(weather.temperatureString)°C"
            self.icon = "\(weather.weatherIcon)"
            self.cityName2 = "\(weather.cityName)"
            print(self.temperature, self.icon)
            self.savedTempArray.append(self.temperature)
            self.savedIconArray.append(self.icon)
            self.savedArray.append(self.cityName2)
            print("savedTempArray \(self.savedTempArray)")
            print("savedIconArray \(self.savedIconArray)")
            print("savedCityArray \(self.savedArray)")
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}



















//Test


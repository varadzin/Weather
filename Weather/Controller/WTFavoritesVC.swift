//
//  WTFavoritesVC.swift
//  Weather
//
//  Created by Frantisek Varadzin on 01/11/2020.
//

import UIKit


class WTFavoritesVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate  {

    var weatherImage = UIImageView()
    var temperature = String()

    let defaults = UserDefaults.standard
    var savedArray : [String] = []
    var savedTempArray : [String] = []
    var savedIconArray : [String] = []
   var collectionView: UICollectionView?

    var weatherManager = WTManager()

    var cityName = String()
    var icon = String()
    let dispatchGroup = DispatchGroup()


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        weatherManager.delegate = self



    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)



        savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()


        savedTempArray = defaults.object(forKey: "SavedTempArray") as? [String] ?? [String]()
        savedIconArray = defaults.object(forKey: "SavedIconArray") as? [String] ?? [String]()
      
        configureCollectionView()
        print("savedArray: \(savedArray), savedTempArray: \(savedTempArray), savedIconArray\(savedIconArray)")

        
      



    }


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

        return savedArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WTCell.identifier, for: indexPath) as! WTCell

        cell.configureCellLabel(label: savedArray[indexPath.row])
        cell.configureTempLabel(tempLabel: savedTempArray[indexPath.row])
            cell.configureWeatherImage(imageView: (UIImage(named: savedIconArray[indexPath.row])!))
        return cell
    }
    
    @objc func didPullToRefresh() {
        //re-fetch data
        print("start refreshing")
        
        DispatchQueue.main.async {
            self.collectionView?.refreshControl?.endRefreshing()
            self.fetchAllValues()
     
            
        }
        
    }
    
    func fetchAllValues() {
      

        savedTempArray.removeAll()
        savedIconArray.removeAll()
        
            for value in savedArray {
                weatherManager.fetchWeather(cityName: value)
               
                
            }
        dispatchGroup.notify(queue: .main) {
            self.reloadCV()
        }
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
    
    
}
 
extension WTFavoritesVC: WTManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WTManager, weather: WTModel) {

        dispatchGroup.enter()
        DispatchQueue.main.async {


            self.temperature = "\(weather.temperatureString)°C"
            self.icon = "\(weather.weatherIcon)"
            print(self.temperature, self.icon)
            self.savedTempArray.append(self.temperature)
            self.savedIconArray.append(self.icon)
            print("savedTempArray \(self.savedTempArray)")
            print("savedIconArray \(self.savedIconArray)")


        }
        dispatchGroup.leave()
        }


    func didFailWithError(error: Error) {
        print(error)
    }
}
















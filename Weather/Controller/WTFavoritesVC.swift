//
//  WTFavoritesVC.swift
//  Weather
//
//  Created by Frantisek Varadzin on 01/11/2020.
//

import UIKit

//class WTFavoritesVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
//    var weatherImage = UIImageView()
//    var savedArray = [String]()
//    var collectionView: UICollectionView?
//    let defaults = UserDefaults.standard
//    var weatherManager = WTManager()
//    var icon = String()
//    var temperature = String()
//    var savedTempArray: [String] = []
//    var savedIconArray : [String] = []
////    var clearBtn = WTSearchBTN(backgroundColor: .systemRed, title: "Clear", titleColor: .white)
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        weatherManager.delegate = self
//        navigationController?.setNavigationBarHidden(true, animated: true)
//
//
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//           super.viewWillAppear(animated)
//        savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
//        savedTempArray = defaults.object(forKey: "SavedTempArray") as? [String] ?? [String]()
//                savedIconArray = defaults.object(forKey: "SavedIconArray") as? [String] ?? [String]()
//        print("savedArray: \(savedArray), savedTempArray: \(savedTempArray), savedIconArray\(savedIconArray)")
//              collectionView?.reloadData()
//
//        fetchAllValues()
//        configureCollectionView()
//
//        print("NOVE savedArray\(savedArray)")
//    }
//
//    func fetchAllValues() {
//        savedTempArray.removeAll()
//        savedIconArray.removeAll()
//        for value in savedArray {
//            weatherManager.fetchWeather(cityName: value)
//
//        }
//
//
//    }
//
////    func configureClearButton() {
////        view.addSubview(clearBtn)
////
////        clearBtn.addTarget(self, action: #selector(clearBtnpressed), for: .touchUpInside)
////        clearBtn.translatesAutoresizingMaskIntoConstraints = false
////
////        NSLayoutConstraint.activate([
////            clearBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
////            clearBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
////            clearBtn.widthAnchor.constraint(equalToConstant: 150),
////            clearBtn.heightAnchor.constraint(equalToConstant: 40)
////        ])
////    }
//
////    @objc func clearBtnpressed() {
////        savedArray.removeAll()
////        savedTempArray.removeAll()
////        savedIconArray.removeAll()
////
////    }
//
//
//    func configureCollectionView() {
//
//
//
//            let layout = UICollectionViewFlowLayout()
//            layout.scrollDirection = .vertical
//            layout.minimumLineSpacing = 1
//            layout.minimumInteritemSpacing = 1
//            layout.itemSize = CGSize(width: (view.frame.size.width/3)-4, height: (view.frame.size.width/3)-4)
//
//            collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//            collectionView?.backgroundColor = .systemBackground
//
//            guard let collectionView = collectionView else {
//                return
//            }
//            collectionView.register(WTCell.self, forCellWithReuseIdentifier: WTCell.identifier)
//            collectionView.dataSource = self
//            collectionView.delegate = self
//
//            collectionView.frame = view.bounds
//
//        view.addSubview(collectionView)
//        }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//
//            return savedArray.count
//        }
//
//        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WTCell.identifier, for: indexPath) as! WTCell
//
//            cell.configureCellLabel(label: savedArray[indexPath.row])
//            print(savedTempArray)
//
//
//
//
//
//            cell.configureTempLabel(tempLabel: savedTempArray[indexPath.row])
////                cell.configureWeatherImage(imageView: (UIImage(named: savedIconArray[indexPath.row])!))
//            return cell
//        }
//
//
//}
//
//
//extension WTFavoritesVC: WTManagerDelegate {
//
//
//    func didUpdateWeather(_ weatherManager: WTManager, weather: WTModel) {
//
//
//
//        DispatchQueue.main.async {
//
//
//            self.temperature = "\(weather.temperatureString)°C"
//            self.icon = "\(weather.weatherIcon)"
//            print(self.temperature, self.icon)
//            self.savedTempArray.append(self.temperature)
//            self.savedIconArray.append(self.icon)
//            print("savedTempArray \(self.savedTempArray)")
//            print("savedIconArray \(self.savedIconArray)")
//
//
//        }
//
//        }
//
//
//    func didFailWithError(error: Error) {
//        print(error)
//    }
//}























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
    
    func fetchAllValues() {
     
            for value in savedArray {
                weatherManager.fetchWeather(cityName: value)
               
                
            }
    
    
        }
}
 
extension WTFavoritesVC: WTManagerDelegate {


    func didUpdateWeather(_ weatherManager: WTManager, weather: WTModel) {


        DispatchQueue.main.async {


            self.temperature = "\(weather.temperatureString)°C"
            self.icon = "\(weather.weatherIcon)"
            print(self.temperature, self.icon)
            self.savedTempArray.append(self.temperature)
            self.savedIconArray.append(self.icon)
            print("savedTempArray \(self.savedTempArray)")
            print("savedIconArray \(self.savedIconArray)")


        }

        }


    func didFailWithError(error: Error) {
        print(error)
    }
}


















//    func updateWeatherValues() {
//
//        cityInArray = ""
//        for i in savedArray {
//            let cityInArray = i
//             weatherManager.fetchWeather(cityName: cityInArray)
//
//    }
//
//
//}

//}
//extension WTFavoritesVC: WTManagerDelegate {
//    func didUpdateWeather(_ weatherManager: WTManager, weather: WTModel) {
//        DispatchQueue.main.async {
//            self.temperature = "\(weather.temperatureString)°C"
//            self.cityName = weather.cityName
//            self.icon = "\(weather.weatherIcon)"
//
//            self.savedTempArray.append(self.temperature)
//            self.savedIconArray.append(self.icon)
//
//            print(self.savedTempArray)
//            print(self.savedIconArray)
//
//
////            self.dictionaryCityTemp.updateValue(self.temperature, forKey: self.cityName)
////            self.dictionaryCityIcon.updateValue(self.icon, forKey: self.cityName)
//
//
//
//
//
//            print(self.dictionaryCityTemp)
//            print(self.dictionaryCityIcon)
////            if self.cityName == "Presov" {
////            print(self.dictionaryCityTemp["Presov"]! + self.dictionaryCityIcon["Presov"]!)
////            }
//
//
//        }
//    }
//
//    func didFailWithError(error: Error) {
//        print(error)
//    }
//}
//
//

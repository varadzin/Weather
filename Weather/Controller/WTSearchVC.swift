//
//  WTSearchVC.swift
//  Weather
//
//  Created by Frantisek Varadzin on 01/11/2020.
//

import UIKit

class WTSearchVC: UIViewController {
    
    var searchTF = WTSearchTF()
    var searchBtn = WTSearchBTN(backgroundColor: .systemBackground, title: "Search", titleColor: .systemBlue)
    var weatherImage = UIImageView()
    var cityAndTempLabel = WTCityLabel()
    var conditionLabel = WTConditionLabel()
    var dayLabel = WTDayLabel(text: "Mon", fontSize: 14)
    var dayLabel2 = WTDayLabel(text: "Tue", fontSize: 14)
    var dayLabel3 = WTDayLabel(text: "Wed", fontSize: 14)
    var dayLabel4 = WTDayLabel(text: "Thu", fontSize: 14)
    var dayWTImage1 = UIImageView()
    var dayWTImage2 = UIImageView()
    var dayWTImage3 = UIImageView()
    var dayWTImage4 = UIImageView()
    var dayTempLabel1 = WTDayLabel(text: "24°C", fontSize: 10)
    var dayTempLabel2 = WTDayLabel(text: "24°C", fontSize: 10)
    var dayTempLabel3 = WTDayLabel(text: "24°C", fontSize: 10)
    var dayTempLabel4 = WTDayLabel(text: "24°C", fontSize: 10)
    var favButton = WTSearchBTN(backgroundColor: .systemBackground, title: "Add to Favorites", titleColor: .systemBlue)
    //    var clearButton = WTSearchBTN(backgroundColor: .systemBackground, title: "Clear Favorites", titleColor: .systemPink)
    var cityToFavorites = String()
    var favoritesArray : [String] = []
    var temperatureLabel = String()
    var tempArray : [String] = []
    var iconArray : [String] = []
    var icon = String()
    var textFieldNotEmpty = Bool()
    var iconImage = UIImageView()
    var smallTempLabel = UILabel()
    let defaults = UserDefaults.standard //declaration for using Userdefaults 
    var weatherManager = WTManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        searchTF.delegate = self
        welcomeScreen()
        configureScreen()
        configureSearchTF()
        configureSearchBtn()
        configureCityLabel()
        configureWTImageView()
        
        configureConditionLabel()
        configureFavButton()
        //        configureClearButton()
        loadArrays()
        configureDayLabel()
        configureDayLabel2()
        configureDayLabel3()
        configureDayLabel4()
        configureDayWTImage1()
        configureDayWTImage2()
        configureDayWTImage3()
        configureDayWTImage4()
        configureTempLabel1()
        configureTempLabel2()
        configureTempLabel3()
        configureTempLabel4()
    }
    
    func configureScreen() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        weatherImage.image = UIImage(named: "02d.png")
    }
    
    func configureSearchTF() {
        view.addSubview(searchTF)
        
        searchTF.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchTF.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            searchTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            searchTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120),
            searchTF.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    func configureSearchBtn() {
        view.addSubview(searchBtn)
        
        searchBtn.addTarget(self, action: #selector(searchPressed), for: .touchUpInside)
        searchBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            searchBtn.leadingAnchor.constraint(equalTo: searchTF.trailingAnchor, constant: 10),
            searchBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            searchBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureCityLabel() {
        view.addSubview(cityAndTempLabel)
        
        cityAndTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityAndTempLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            cityAndTempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityAndTempLabel.heightAnchor.constraint(equalToConstant: 40),
            cityAndTempLabel.widthAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    func configureWTImageView() {
        view.addSubview(weatherImage)
        
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherImage.bottomAnchor.constraint(equalTo: cityAndTempLabel.topAnchor, constant: -30),
            weatherImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherImage.widthAnchor.constraint(equalToConstant: 190),
            weatherImage.heightAnchor.constraint(equalToConstant: 190)
        ])
    }
    
    
    
    
    func configureConditionLabel() {
        view.addSubview(conditionLabel)
        
        conditionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            conditionLabel.topAnchor.constraint(equalTo: cityAndTempLabel.bottomAnchor, constant: 5),
            conditionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            conditionLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    func configureFavButton() {
        view.addSubview(favButton)
        
        favButton.addTarget(self, action: #selector(favBtnPressed), for: .touchUpInside)
        favButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            favButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favButton.widthAnchor.constraint(equalToConstant: 150),
            favButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func welcomeScreen() {
        cityAndTempLabel.text = "Weather Today"
        conditionLabel.text = "in your favorites cities"
        
    }
    
    //    func configureClearButton() {
    //        view.addSubview(clearButton)
    //
    //        clearButton.addTarget(self, action: #selector(clearFavorites), for: .touchUpInside)
    //        clearButton.translatesAutoresizingMaskIntoConstraints = false
    //
    //        NSLayoutConstraint.activate([
    //            clearButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
    //            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
    //            clearButton.widthAnchor.constraint(equalToConstant: 150)
    //        ])
    //    }
    
    
    func showAlert() {
        print("error")
        
    }
    //MARK: - Loading saved arrays in UserDefaults
    func loadArrays() {
        
        favoritesArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        
        tempArray = defaults.object(forKey: "SavedTempArray") as? [String] ?? [String]()
        
        iconArray = defaults.object(forKey: "SavedIconArray") as? [String] ?? [String]()
        
        print("savedArray: \(favoritesArray), savedTempArray: \(tempArray), savedIconArray\(iconArray)")
    }
    
    
    @objc func favBtnPressed() {
        if textFieldNotEmpty == false {
            searchTF.placeholder = "Type something"
        } else {
            
            if favoritesArray.contains(cityToFavorites) {
                showAlert()
                
            } else {
                let favoritesVC = WTFavoritesVC()
                favoritesVC.title = "Favorites Cities"
                
                
                //MARK: - append value to array
                favoritesArray.append(cityToFavorites)
                tempArray.append(temperatureLabel)
                iconArray.append(icon)
                
                //MARK: - saving arrays to UserDefaults "Memory"
                defaults.set(favoritesArray, forKey: "SavedArray")
                defaults.set(tempArray, forKey: "SavedTempArray")
                defaults.set(iconArray, forKey: "SavedIconArray")
                
                //                navigationController?.pushViewController(favoritesVC, animated: true)
                
            }
        }
    }
    func configureDayLabel() {
        view.addSubview(dayLabel)
        
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -100),
            dayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            dayLabel.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureDayLabel2() {
        view.addSubview(dayLabel2)
        
        dayLabel2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel2.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -100),
            dayLabel2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 138),
            dayLabel2.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureDayLabel3() {
        view.addSubview(dayLabel3)
        
        dayLabel3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel3.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -100),
            dayLabel3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -125),
            dayLabel3.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureDayLabel4() {
        view.addSubview(dayLabel4)
        
        dayLabel4.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel4.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -100),
            dayLabel4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            dayLabel4.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureDayWTImage1() {
        view.addSubview(dayWTImage1)
        
        dayWTImage1.image = UIImage(named: "01d")
        dayWTImage1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayWTImage1.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -60),
            dayWTImage1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            dayWTImage1.widthAnchor.constraint(equalToConstant: 30),
            dayWTImage1.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    func configureDayWTImage2() {
        view.addSubview(dayWTImage2)
        
        dayWTImage2.image = UIImage(named: "01d")
        dayWTImage2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayWTImage2.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -60),
            dayWTImage2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 135),
            dayWTImage2.widthAnchor.constraint(equalToConstant: 30),
            dayWTImage2.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    func configureDayWTImage3() {
        view.addSubview(dayWTImage3)
        
        dayWTImage3.image = UIImage(named: "01d")
        dayWTImage3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayWTImage3.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -60),
            dayWTImage3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -135),
            dayWTImage3.widthAnchor.constraint(equalToConstant: 30),
            dayWTImage3.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    func configureDayWTImage4() {
        view.addSubview(dayWTImage4)
        
        dayWTImage4.image = UIImage(named: "01d")
        dayWTImage4.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayWTImage4.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -60),
            dayWTImage4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            dayWTImage4.widthAnchor.constraint(equalToConstant: 30),
            dayWTImage4.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    func configureTempLabel1() {
        view.addSubview(dayTempLabel1)
        
        dayTempLabel1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayTempLabel1.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -40),
            dayTempLabel1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            dayTempLabel1.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureTempLabel2() {
        view.addSubview(dayTempLabel2)
        
        dayTempLabel2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayTempLabel2.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -40),
            dayTempLabel2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 140),
            dayTempLabel2.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureTempLabel3() {
        view.addSubview(dayTempLabel3)
        
        dayTempLabel3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayTempLabel3.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -40),
            dayTempLabel3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -125),
            dayTempLabel3.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureTempLabel4() {
        view.addSubview(dayTempLabel4)
        
        dayTempLabel4.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayTempLabel4.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -40),
            dayTempLabel4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            dayTempLabel4.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}

//    @objc func clearFavorites() {
//        defaults.dictionaryRepresentation().keys.forEach(defaults.removeObject(forKey:))
//        favoritesArray.removeAll()
//        tempArray.removeAll()
//        iconArray.removeAll()
//
//
//
//    }



//MARK: - UITextFieldDelegate

extension WTSearchVC: UITextFieldDelegate {
    
    @objc func searchPressed(_ sender: UIButton) {
        searchTF.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTF.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            textFieldNotEmpty = true
            return true
        } else {
            textField.placeholder = "Type something"
            textFieldNotEmpty = false
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTF.text {
            weatherManager.fetchWeather(cityName: city)
            
            
        }
        searchTF.text = ""
    }
    
    
    
}

//MARK: - WTManagerDelegate

extension WTSearchVC: WTManagerDelegate {
    func didUpdateWeather(_ weatherManager: WTManager, weather: WTModel) {
        DispatchQueue.main.async {
            self.weatherImage.image = UIImage(named: weather.weatherIcon)
            self.icon = "\(weather.weatherIcon)"
            self.cityAndTempLabel.text = "\(weather.cityName) \(weather.temperatureString)°C"
            self.temperatureLabel = "\(weather.temperatureString)°C"
            self.conditionLabel.text = "\(weather.weatherDescription),  wind: \(weather.windSpeedString) m/s"
            self.cityToFavorites = weather.cityName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
   
    func didupdateForecast(_ forecastManager: FCManager, forecast: FCModel) {
        DispatchQueue.main.async {
            <#code#>
        }
        
        
    }

    
    
    
    
}

//MARK: - Name of Day
//
//extension Date {
//
//    func dayNameOfWeek() -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "EEEE"
//        return dateFormatter.string(from: self)
//
//    }
//
//}



//





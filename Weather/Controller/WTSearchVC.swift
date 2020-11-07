//
//  WTSearchVC.swift
//  Weather
//
//  Created by Frantisek Varadzin on 01/11/2020.
//

import UIKit

class WTSearchVC: UIViewController {
    
    var searchTF = WTSearchTF()
    var searchBtn = WTSearchBTN(backgroundColor: .systemBackground, title: "search", titleColor: .systemBlue)
    var weatherImage = UIImageView()
    var cityAndTempLabel = WTCityLabel()
    var conditionLabel = WTConditionLabel()
    var dayLabel = WTDayLabel()
    var dayLabel2 = WTDayLabel()
    var dayLabel3 = WTDayLabel()
    var dayLabel4 = WTDayLabel()
    var dayLabel5 = WTDayLabel()
    var favButton = WTSearchBTN(backgroundColor: .systemBackground, title: "favorites cities", titleColor: .systemBlue)
    
    
    
    var iconImage = UIImageView()
    var smallTempLabel = UILabel()
    var date = 10/10/2020

    
    
    var weatherManager = WTManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.isHidden = true
        
        weatherImage.image = UIImage(named: "02d.png")
        
        weatherManager.delegate = self
        searchTF.delegate = self
        
        configureSearchTF()
        configureSearchBtn()
        configureWTImageView()
        configureCityLabel()
        configureConditionLabel()
        configureDayLabel()
        configureDayLabel2()
        configureDayLabel3()
        configureDayLabel4()
        configureDayLabel5()
        configureFavButton()
        
        
        
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
    
    func configureWTImageView() {
        view.addSubview(weatherImage)
        
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherImage.topAnchor.constraint(equalTo: searchTF.bottomAnchor, constant: 30),
            weatherImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherImage.widthAnchor.constraint(equalToConstant: 190),
            weatherImage.heightAnchor.constraint(equalToConstant: 190)
        ])
    }
    
    func configureCityLabel() {
        view.addSubview(cityAndTempLabel)
        
        cityAndTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityAndTempLabel.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 10),
            cityAndTempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cityAndTempLabel.heightAnchor.constraint(equalToConstant: 40),
            cityAndTempLabel.widthAnchor.constraint(equalToConstant: 250)
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

    func configureDayLabel() {
        view.addSubview(dayLabel)
       
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 50),
            dayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            dayLabel.widthAnchor.constraint(equalToConstant: 100)
                    ])
            }
    
    func configureDayLabel2() {
        view.addSubview(dayLabel2)
       
        dayLabel2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel2.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 50),
            dayLabel2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 95),
            dayLabel2.widthAnchor.constraint(equalToConstant: 100)
                    ])
            }
    
    func configureDayLabel3() {
        view.addSubview(dayLabel3)
       
        dayLabel3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel3.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 50),
            dayLabel3.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 160),
            dayLabel3.widthAnchor.constraint(equalToConstant: 100)
                    ])
            }
    
    func configureDayLabel4() {
        view.addSubview(dayLabel4)
       
        dayLabel4.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel4.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 50),
            dayLabel4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 230),
            dayLabel4.widthAnchor.constraint(equalToConstant: 100)
                    ])
            }
 
    
    func configureDayLabel5() {
        view.addSubview(dayLabel5)
       
        dayLabel5.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel5.topAnchor.constraint(equalTo: conditionLabel.bottomAnchor, constant: 50),
            dayLabel5.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 295),
            dayLabel5.widthAnchor.constraint(equalToConstant: 100)
                    ])
            }
    
    
    func configureFavButton() {
        view.addSubview(favButton)
        
        favButton.addTarget(self, action: #selector(favBtnPressed), for: .touchUpInside)
        favButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            favButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            favButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            favButton.widthAnchor.constraint(equalToConstant: 150)
        
        ])
          
    }
    
    @objc func favBtnPressed(_ sender: UIButton) {
        let favoritesVC = WTFavoritesVC()
        favoritesVC.title = "Favorites Cities"
        print("btn pressed")
        
        navigationController?.pushViewController(favoritesVC, animated: true)
        
        
        
        
        
    }
    
    
    
}






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
            return true
        } else {
            textField.placeholder = "Type something"
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
            self.cityAndTempLabel.text = "\(weather.cityName) \(weather.temperatureString)°C"
            self.conditionLabel.text = "\(weather.weatherDescription),  wind: \(weather.windSpeedString) m/s"
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
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

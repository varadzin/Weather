//
//  WTSearchVC.swift
//  Weather
//
//  Created by Frantisek Varadzin on 01/11/2020.
//

import UIKit

class WTSearchVC: UIViewController {
    
    
    // Labels on screen
    var dayLabel1 = WTDayLabel(fontSize: 14)
    var dayLabel2 = WTDayLabel(fontSize: 14)
    var dayLabel3 = WTDayLabel(fontSize: 14)
    var dayLabel4 = WTDayLabel(fontSize: 14)
    var dayTimeLabel1 = WTDayLabel(fontSize: 8)
    var dayTimeLabel2 = WTDayLabel(fontSize: 8)
    var dayTimeLabel3 = WTDayLabel(fontSize: 8)
    var dayTimeLabel4 = WTDayLabel(fontSize: 8)
    var dayWTImage1 = UIImageView()
    var dayWTImage2 = UIImageView()
    var dayWTImage3 = UIImageView()
    var dayWTImage4 = UIImageView()
    var dayTempLabel1 = WTDayLabel()
    var dayTempLabel2 = WTDayLabel(fontSize: 10)
    var dayTempLabel3 = WTDayLabel(fontSize: 10)
    var dayTempLabel4 = WTDayLabel(fontSize: 10)
    var favButton = WTSearchBTN(backgroundColor: .systemBlue, title: "Add to Favorites", titleColor: .white, titleColorHighlighted: .systemBlue,  borderColor: .systemBlue)
    var favoritesIsEmpty = false
    var searchTF = WTSearchTF()
    var searchBtn = WTSearchBTN(backgroundColor: .systemBlue, title: "Search", titleColor: .systemBlue, titleColorHighlighted: .systemBlue, borderColor: .systemBlue)
    var weatherImage = UIImageView()
    var cityAndTempLabel = WTCityLabel()
    var conditionLabel = WTConditionLabel()
    var smallTempLabel = UILabel()
    
    //Arrays
    var tempArray : [String] = []
    var iconArray : [String] = []
    var favoritesArray : [String] = []
    var newTimeEntries : [Int] = []
    var newDayEntries : [String] = []
    var citiesToRefresh : [String] = []
    var timeEntries : [Int] = [6,12,18,24]
    
    //Variables - used in Network Manager
    var cityToFavorites = String()
    var temperatureLabel = String()
    var icon = String()
    var forecastName = String()
    var iconImage = UIImageView()
    let defaults = UserDefaults.standard //declaration for using Userdefaults
    
    //Variables - Forecast
    var actualWeekDay = String()
    var day = Int()
    var hour = Int()
    var updatedHour = Int()
    var updatedDay = Int()
    var newHour = Int()
    
    //Variables for Delegate
    var weatherManager = WTManager()
    var forecastManager = ForecastManager()
    
    //Other variables
    var textFieldNotEmpty = Bool()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        forecastManager.delegate = self
        searchTF.delegate = self
        
        loadArrays()
        
        welcomeScreen()
        configureScreen()
        configureSearchTF()
        configureSearchBtn()
        configureCityLabel()
        configureWTImageView()
        configureConditionLabel()
        configureFavButton()
        
        configureDayLabel1()
        configureDayLabel2()
        configureDayLabel3()
        configureDayLabel4()
        
        configureDayTimeLabel1()
        configureDayTimeLabel2()
        configureDayTimeLabel3()
        configureDayTimeLabel4()
        
        configureDayWTImage1()
        configureDayWTImage2()
        configureDayWTImage3()
        configureDayWTImage4()
        
        configureTempLabel1()
        configureTempLabel2()
        configureTempLabel3()
        configureTempLabel4()
        
        createDismissKeyboardTapGesture()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                dataBtwVC()
            }
    
    //MARK: Data Exchange between WTSearchVC and WTFavoritesVC
    func dataBtwVC() {
        favoritesIsEmpty = defaults.object(forKey: "FavoritesDeleted") as? Bool ?? Bool()
        if favoritesIsEmpty == false {
            citiesToRefresh = favoritesArray
        } else {
            citiesToRefresh.removeAll()
        }
        tempArray.removeAll()
        iconArray.removeAll()
        favoritesArray.removeAll()
        fetchFavorites()
        favoritesIsEmpty = false
        self.defaults.set(self.favoritesIsEmpty, forKey: "FavoritesDeleted")
    }
    
    
        
    //MARK: - Forecast - small icons and small labels
    
    //what weekday is today
    //what hour do we have now
    func actualDay() {
        let date = Date()
        let calendar = Calendar.current
        day = calendar.component(.weekday, from: date)
        hour = calendar.component(.hour, from: date)
        timeEntriesFunc()
    }
    
    //take actual hour and update it +6, +12, +18, +24 hours
    func timeEntriesFunc() {
        newTimeEntries = []
        newDayEntries = []
        
        for timeEnter in timeEntries {
            updatedHour = hour + timeEnter
            newDay(updatedHour: updatedHour)
        }
    }
    
    //take today week day and update it +6, +12, +18, +24 hours
    // if new day starts update hour -24 hours and append it in Array
    
    func newDay(updatedHour: Int) {
        updatedDay = 0
        switch updatedHour {
        case 0...23:
            newHour = updatedHour
            updatedDay = day
        case 24...47:
            updatedDay = day + 1
            newHour = updatedHour - 24
        default:
            print("something wrong")
        }
        actualWeekDayFunc(updatedDay: updatedDay)
        newTimeEntries.append(newHour)
    }
    
    //take actual weekday and append it in Array (today or tommorow)
    func actualWeekDayFunc(updatedDay: Int) {
        
        switch updatedDay {
        case 0:
            actualWeekDay = "0"
        case 1:
            actualWeekDay = "Sun"
        case 2:
            actualWeekDay = "Mon"
        case 3:
            actualWeekDay = "Tue"
        case 4:
            actualWeekDay = "Wed"
        case 5:
            actualWeekDay = "Thu"
        case 6:
            actualWeekDay = "Fri"
        case 7:
            actualWeekDay = "Sat"
        case 8:
            actualWeekDay = "Sun"
        default:
            actualWeekDay = "default"
        }
        newDayEntries.append(actualWeekDay)
    }
    
    //MARK: - Loading saved arrays in UserDefaults
    func loadArrays() {
        defaults.set(favoritesIsEmpty, forKey: "FavoritesDeleted")
        favoritesArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
        citiesToRefresh = favoritesArray
    }
    
    
    
    //MARK: - What happens after tapping Add to Favorites
    @objc func favBtnPressed() {
        if textFieldNotEmpty == false {
            searchTF.placeholder = "Type something"
        } else {
            if favoritesArray.count >= 20 {
                simpleAlert(title: "Thats enough!", message: "You have reached maximum favorites cities")
            } else {
                if favoritesArray.contains(cityToFavorites) {
                    showAlert()
                } else {
                    let favoritesVC = WTFavoritesVC()
                    favoritesVC.title = "Favorites Cities"
                    
                    //MARK: - append value to array - new city to Favorites
                    
                    favoritesArray.append(cityToFavorites)
                    tempArray.append(temperatureLabel)
                    iconArray.append(icon)
                    
                    //MARK: - saving arrays to UserDefaults "Memory"
                    defaults.set(favoritesArray, forKey: "SavedArray") 
                    defaults.set(tempArray, forKey: "SavedTempArray")
                    defaults.set(iconArray, forKey: "SavedIconArray")
                                    }
            }
        }
    }
    
    func fetchFavorites() {
        for value in citiesToRefresh {
            forecastManager.fetchWeather(cityName: value)
        }
    }
    
    
    //MARK: Delay to wait till API Data load
    func run(after seconds: Int, completion: @escaping () -> Void) {
        let deadline = DispatchTime.now() + .seconds(seconds)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            completion()
        }
    }
    
        //MARK: - Other fcions - Dismiss Keyboard, Alert, Welcome screen
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    func simpleAlert(title: String, message: String) {
                let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func welcomeScreen() {
        cityAndTempLabel.text = "Weather Today"
        conditionLabel.text = "in your favorites cities"
    }
    
    func showAlert() {
        print("error")
    }
    
        //MARK: - Configuring Labels, images, Fields, Buttons on screen
    
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
            favButton.widthAnchor.constraint(equalToConstant: 120),
            favButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    func configureDayLabel1() {
        view.addSubview(dayLabel1)
        
        dayLabel1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel1.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -100),
            dayLabel1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 63),
            dayLabel1.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureDayTimeLabel1() {
        view.addSubview(dayTimeLabel1)
        
        dayTimeLabel1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayTimeLabel1.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -85),
            dayTimeLabel1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 63),
            dayTimeLabel1.widthAnchor.constraint(equalToConstant: 40)
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
    
    func configureDayTimeLabel2() {
        view.addSubview(dayTimeLabel2)
        
        dayTimeLabel2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayTimeLabel2.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -85),
            dayTimeLabel2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 138),
            dayTimeLabel2.widthAnchor.constraint(equalToConstant: 40)
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
    
    func configureDayTimeLabel3() {
        view.addSubview(dayTimeLabel3)
        
        dayTimeLabel3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayTimeLabel3.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -85),
            dayTimeLabel3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -123),
            dayTimeLabel3.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureDayLabel4() {
        view.addSubview(dayLabel4)
        
        dayLabel4.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayLabel4.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -100),
            dayLabel4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -49),
            dayLabel4.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureDayTimeLabel4() {
        view.addSubview(dayTimeLabel4)
        
        dayTimeLabel4.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayTimeLabel4.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -85),
            dayTimeLabel4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -47),
            dayTimeLabel4.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    
    func configureDayWTImage1() {
        view.addSubview(dayWTImage1)
        
        dayWTImage1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayWTImage1.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -50),
            dayWTImage1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            dayWTImage1.widthAnchor.constraint(equalToConstant: 30),
            dayWTImage1.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureDayWTImage2() {
        view.addSubview(dayWTImage2)
        
        dayWTImage2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayWTImage2.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -50),
            dayWTImage2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 135),
            dayWTImage2.widthAnchor.constraint(equalToConstant: 30),
            dayWTImage2.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureDayWTImage3() {
        view.addSubview(dayWTImage3)
        
        dayWTImage3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayWTImage3.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -50),
            dayWTImage3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -135),
            dayWTImage3.widthAnchor.constraint(equalToConstant: 30),
            dayWTImage3.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    func configureDayWTImage4() {
        view.addSubview(dayWTImage4)
        
        dayWTImage4.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayWTImage4.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -50),
            dayWTImage4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            dayWTImage4.widthAnchor.constraint(equalToConstant: 30),
            dayWTImage4.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    func configureTempLabel1() {
        view.addSubview(dayTempLabel1)
        dayTempLabel1.font = UIFont.systemFont(ofSize: 10)
        dayTempLabel1.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayTempLabel1.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -30),
            dayTempLabel1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            dayTempLabel1.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureTempLabel2() {
        view.addSubview(dayTempLabel2)
        
        dayTempLabel2.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayTempLabel2.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -30),
            dayTempLabel2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 140),
            dayTempLabel2.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureTempLabel3() {
        view.addSubview(dayTempLabel3)
        
        dayTempLabel3.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayTempLabel3.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -30),
            dayTempLabel3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -123),
            dayTempLabel3.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func configureTempLabel4() {
        view.addSubview(dayTempLabel4)
        
        dayTempLabel4.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dayTempLabel4.bottomAnchor.constraint(equalTo: favButton.topAnchor, constant: -30),
            dayTempLabel4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -47),
            dayTempLabel4.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}


//MARK: - UITextFieldDelegate - Magic happens after Tap search Button

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
            actualDay()
        }
        searchTF.text = ""
    }
}

//MARK: - ForecastDelegate - data from API - JSON - Forecast

extension WTSearchVC: ForecastManagerDelegate {
    func didUpdateForecast(_ forecastManager: ForecastManager, weather: WTModel) {
        DispatchQueue.main.sync {
            
            self.icon = "\(weather.weatherIcon)"
            self.temperatureLabel = "\(weather.temperatureString)°C"
            self.forecastName = "\(weather.cityName)"
            
            self.tempArray.append(self.temperatureLabel)
            self.iconArray.append(self.icon)
            self.favoritesArray.append(self.forecastName)
            
            print("TempArray is \(self.tempArray) and IconArray is \(self.iconArray) and city is \(self.favoritesArray)")
            self.defaults.set(self.tempArray, forKey: "SavedTempArray")
            self.defaults.set(self.iconArray, forKey: "SavedIconArray")
            self.defaults.set(self.favoritesArray, forKey: "SavedArray")
        }
    }
    
    func didFailWithErrorForecast(error: Error) {
        print(error)
    }
}


//MARK: - WTManagerDelegate - data from API - JSON

extension WTSearchVC: WTManagerDelegate {
    
    func didUpdateWeather(_ weatherManager: WTManager, weather: WTModel) {
        DispatchQueue.main.async {
            self.weatherImage.image = UIImage(named: weather.weatherIcon)
            self.icon = "\(weather.weatherIcon)"
            self.cityAndTempLabel.text = "\(weather.cityName) \(weather.temperatureString)°C"
            self.temperatureLabel = "\(weather.temperatureString)°C"
            self.conditionLabel.text = "\(weather.weatherDescription),  wind: \(weather.windSpeedString) m/s"
            self.cityToFavorites = weather.cityName
            self.dayLabel1.text = "\(self.newDayEntries[0])"
            self.dayTimeLabel1.text = "\(self.newTimeEntries[0]):00"
            self.dayTempLabel1.text = "\(weather.forecastTemperature1)°C"
            self.dayWTImage1.image = UIImage(named: weather.forecastIcon1)
            
            self.dayLabel2.text = "\(self.newDayEntries[1])"
            self.dayTimeLabel2.text = "\(self.newTimeEntries[1]):00"
            self.dayTempLabel2.text = "\(weather.forecastTemperature2)°C"
            self.dayWTImage2.image = UIImage(named: weather.forecastIcon2)
            
            self.dayLabel3.text = "\(self.newDayEntries[2])"
            self.dayTimeLabel3.text = "\(self.newTimeEntries[2]):00"
            self.dayTempLabel3.text = "\(weather.forecastTemperature3)°C"
            self.dayWTImage3.image = UIImage(named: weather.forecastIcon3)
            
            self.dayLabel4.text = "\(self.newDayEntries[3])"
            self.dayTimeLabel4.text = "\(self.newTimeEntries[3]):00"
            self.dayTempLabel4.text = "\(weather.forecastTemperature4)°C"
            self.dayWTImage4.image = UIImage(named: weather.forecastIcon4)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}






//
//  ViewController.swift
//  WeatherAppbySeneca
//
//  Created by Дмитрий Дмитрий on 12.01.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    var weather: Weather?
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyKilometer
        lm.requestWhenInUseAuthorization()
        return lm
    }()
    
    @IBAction func searchPressed(_ sender: UIButton) {
        showAlert(title: "Enter city name", message: nil) { city in
            NetworkManager.shared.fetchCurrentWeather(forRequestType: .cityName(city: city)) { [weak self] results in
                switch results {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let weather):
                    self?.weather = weather
                    self?.updateInterfaceElements()
//                    self?.cityLabel.text = weather.name
//                    self?.temperatureLabel.text = weather.main?.temperature
//                    self?.feelsLikeTemperatureLabel.text = weather.main?.feelsLikeTemp
                }
            }
        }
    }
    
    override func viewDidLoad() {
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }

    func updateInterfaceElements() {
        cityLabel.text = self.weather?.name
        temperatureLabel.text = self.weather?.main?.temperature
        feelsLikeTemperatureLabel.text = self.weather?.main?.feelsLikeTemp
        weatherIconImageView.image = UIImage(systemName: self.weather?.weather?.first?.systemIconNameString ?? "")
    }
}

//MARK: - CLLocationManagerDelegate
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        NetworkManager.shared.fetchCurrentWeather(forRequestType: .coordinate(latitude: latitude, longitude: longitude)) { [weak self] results in
            switch results {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let weather):
                self?.weather = weather
                self?.updateInterfaceElements()
            }
        }
    }
        
        func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error.localizedDescription)
        }
    
}

//
//  ViewController.swift
//  WeatherAppbySeneca
//
//  Created by Дмитрий Дмитрий on 12.01.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var weather: Weather?
    
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeTemperatureLabel: UILabel!
    
    
    @IBAction func searchPressed(_ sender: UIButton) {
        showAlert(title: "Enter city name", message: nil) { city in
            NetworkManager.shared.fetchCurrentWeather(for: city) { results in
                switch results {
                case .failure(let error):
                    print(error.localizedDescription)
                case .success(let weather):
                    self.weather = weather
                    self.cityLabel.text = weather.name
                    self.temperatureLabel.text = weather.main?.temperature
                    self.feelsLikeTemperatureLabel.text = weather.main?.feelsLikeTemp
                }
            }
        }
    }
    
    override func viewDidLoad() {
            
        }
        
    
}



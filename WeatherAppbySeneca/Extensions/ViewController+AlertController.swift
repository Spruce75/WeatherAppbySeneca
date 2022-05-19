//
//  ViewController+AlertController.swift
//  WeatherAppbySeneca
//
//  Created by Дмитрий Дмитрий on 12.01.2022.
//

import UIKit

extension ViewController {
    func showAlert(title: String?, message: String?, completion: @escaping (String) -> Void) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addTextField { textField in
            let cities = ["Moscow", "Tampere", "Helsinki", "New York"]
            textField.placeholder = cities.randomElement()
        }
        
        let searchAction = UIAlertAction(title: "Search", style: .default) { action in
            let textField = alert.textFields?.first
            guard let cityName = textField?.text else { return }
            if cityName != "" {
                let city = cityName.split(separator: " ").joined(separator: "%20")
                completion(city)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(searchAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
    }
    
}

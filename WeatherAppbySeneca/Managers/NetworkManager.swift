//
//  NetworkManager.swift
//  WeatherAppbySeneca
//
//  Created by Дмитрий Дмитрий on 18.05.2022.
//

import UIKit
import CoreLocation

enum NetworkError: Error {
    case someError(message: String)
}

enum RequestType {
    case cityName(city: String)
    case coordinate(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
}

class NetworkManager {
    private init() {}
    static let shared = NetworkManager()
    
    func fetchCurrentWeather(forRequestType requestType: RequestType, completion: @escaping(Result<Weather, NetworkError>) -> Void) {
        var apiUrl = ""
        switch requestType {
        case .cityName(let city):
            apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(ApiManager.shared.apiKey)&units=metric"
        case .coordinate(let latitude, let longitude):
            apiUrl = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&apikey=\(ApiManager.shared.apiKey)&units=metric"
            guard let stringUrl = URL(string: apiUrl) else { return }
            
            URLSession.shared.dataTask(with: stringUrl) { data, response, error in
                guard let data = data, let response = response else {
                    completion(.failure(.someError(message: error?.localizedDescription ?? "No error dscription")))
                    return
                }
                print(response)
                do {
                    let weatherData = try JSONDecoder().decode(Weather.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(weatherData))
                    }
                } catch let error {
                    completion(.failure(.someError(message: error.localizedDescription)))
                }
            }.resume()
        }
    }
}

//    func fetchCurrentWeather(for city: String, completion: @escaping(Result<Weather, NetworkError>) -> Void) {
//        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(ApiManager.shared.apiKey)&units=metric"
//        guard let stringUrl = URL(string: apiUrl) else { return }
//
//        URLSession.shared.dataTask(with: stringUrl) { data, response, error in
//            guard let data = data, let response = response else {
//                completion(.failure(.someError(message: error?.localizedDescription ?? "No error dscription")))
//                return
//            }
//            print(response)
//            do {
//                let weatherData = try JSONDecoder().decode(Weather.self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(weatherData))
//                }
//            } catch let error {
//                completion(.failure(.someError(message: error.localizedDescription)))
//            }
//        }.resume()
//    }
//
//    func fetchCurrentWeather(for latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping(Result<Weather, NetworkError>) -> Void) {
//        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&apikey=\(ApiManager.shared.apiKey)&units=metric"
//        guard let stringUrl = URL(string: apiUrl) else { return }
//
//        URLSession.shared.dataTask(with: stringUrl) { data, response, error in
//            guard let data = data, let response = response else {
//                completion(.failure(.someError(message: error?.localizedDescription ?? "No error dscription")))
//                return
//            }
//            print(response)
//            do {
//                let weatherData = try JSONDecoder().decode(Weather.self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(weatherData))
//                }
//            } catch let error {
//                completion(.failure(.someError(message: error.localizedDescription)))
//            }
//
//        }.resume()
//    }
//}


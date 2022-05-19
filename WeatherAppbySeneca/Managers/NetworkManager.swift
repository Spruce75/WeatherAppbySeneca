//
//  NetworkManager.swift
//  WeatherAppbySeneca
//
//  Created by Дмитрий Дмитрий on 18.05.2022.
//

import UIKit

enum NetworkError: Error {
    case someError(message: String)
}

//class NetworkManager {
//    private init() {}
//    static let shared = NetworkManager()
//
//    func fetchCurrentWeathe(for city: String) {
//        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(ApiManager.shared.apiKey)"
//        guard let stringUrl = URL(string: apiUrl) else { return }
//
//        URLSession.shared.dataTask(with: apiUrl) { data, response, error in
//            if let data = data {
//                print()
//            }
//        }.resume()
//    }
//}

class NetworkManager {
    private init() {}
    static let shared = NetworkManager()

    func fetchCurrentWeather(for city: String, completion: @escaping(Result<Weather, NetworkError>) -> Void) {
        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&apikey=\(ApiManager.shared.apiKey)"
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
                    print(weatherData)
                }
            } catch let error {
                completion(.failure(.someError(message: error.localizedDescription)))
            }

        }.resume()

    }
}

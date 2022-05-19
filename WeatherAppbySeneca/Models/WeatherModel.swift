//
//  WeatherModel.swift
//  WeatherAppbySeneca
//
//  Created by Дмитрий Дмитрий on 19.05.2022.
//

import Foundation

struct Weather: Codable {
    let name: String?
    let weather: [WeatherDescription]?
    let main: WeatherDetails?
    
}

struct WeatherDescription: Codable {
    let id: Int?
    let description: String?
}

struct WeatherDetails: Codable {
    let temp: Double?
    let feelsLike: Double?
    let pressure: Int?
    let humidity: Int?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case pressure
        case humidity
    }
    
    var temperature: String {
        "\(temp?.rounded() ?? 0)"
    }
    
    var feelsLikeTemp: String {
        "\(feelsLike?.rounded() ?? 0)"
    }
}

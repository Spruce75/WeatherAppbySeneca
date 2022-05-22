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
    
    var systemIconNameString: String {
        guard let id = id else { return ""}
        switch id {
        case 200...232: return "cloud.bolt.rain.fill"
        case 300...321: return "cloud.drizzle.fill"
        case 500...531: return "cloud.rain.fill"
        case 600...622: return "cloud.snow.fill"
        case 701...781: return "smoke.fill"
        case 800: return "sun.min.fill"
        case 801...804: return "cloud.fill"
        default: return "nosign"
        }
    }
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
        guard let temp = temp else { return ""}
        return String(format: "%.0f", temp)
    }
    
    var feelsLikeTemp: String {
        guard let feelsLike = feelsLike else { return ""}
        return String(format: "%.0f", feelsLike)
    }
}

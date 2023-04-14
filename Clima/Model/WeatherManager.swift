//
//  WeatherManager.swift
//  Clima
//
//  Created by Muhammet BOZKURT on 12.04.2023.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    //    let apiKey:String = "7caf51674be66191ee2074731eb10539"
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=7caf51674be66191ee2074731eb10539&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        // Step 1 : Create URL
        if let url = URL(string: urlString) {
            // Step 2 : Create a URLSession
            let session = URLSession(configuration: .default)
            // Step 3 : Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    self.parseJSON(weatherData: safeData)
                }
            }
            // Step 4 : Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].description)
        } catch {
            print(error)
        }
    }
    
}

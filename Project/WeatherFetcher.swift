//
//  WeatherFetcher.swift
//  Project
//
//  Created by Tarin Rickett on 12/15/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import Foundation

//throw error if invalid
enum WeatherError: Error {
    case InvalidWeatherJSONError
    case NotYetImplementedError
}

//throw success or failure result
enum WeatherResult {
    case WeatherSuccess(TripItem)
    case WeatherFailure(Error)
}

class WeatherFetcher {
    //constants to build the URL
    private static let url = "http://api.openweathermap.org/data/2.5/weather"
    private static let query2 = "&APPID="
    private static let appID = "9a9484ed07694b9dc82b020326341829"
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchWeather(for location: String, completion: @escaping (WeatherResult) -> Void) {
        let weatherURL = WeatherFetcher.getURL(for: location)
        let request = URLRequest(url: weatherURL)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            guard let weatherData = data else {
                completion(.WeatherFailure(error!))
                return
            }
            completion(WeatherFetcher.getWeather(from: weatherData))
        }
        task.resume()
    }
    
    private static func getURL(for location: String) -> URL {
        var components = URLComponents(string: url)!
        var queryItems = [URLQueryItem]()
        queryItems.append(URLQueryItem(name: "id", value: location))
        queryItems.append(URLQueryItem(name: "APPID", value: "9a9484ed07694b9dc82b020326341829"))
        components.queryItems = queryItems
        return components.url!
    }
    
    private static func getWeather(from json: Data) -> WeatherResult {
        do {
            let jsonObject: Any = try JSONSerialization.jsonObject(with: json, options: [])
            guard let jsonDict = jsonObject as? [String:AnyObject],
                let location = jsonDict["name"] as? String,
                let temp = jsonDict["main"] as? [String:AnyObject],
                var forecast = jsonDict["weather"] as? [AnyObject] else {
                    return .WeatherFailure(WeatherError.InvalidWeatherJSONError)
            }
            
            //let weather = all JSON return values
            let forecastWeather = forecast[0]["main"] as? String
            let weather = TripItem(location, forecastWeather!, (temp["temp"] as? Int)!)
            
            return .WeatherSuccess(weather)
        }
        catch let error {
            return .WeatherFailure(error)
        }
    }
    
}

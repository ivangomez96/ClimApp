//
//  WeatherRequest.swift
//  ClimApp
//
//  Created by Ivan on 16/11/2020.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

enum WeatherError: Error {
    case invalidApiKey
    case resourceNotFound
}

struct WeatherRequest {
    
    let apiKey = "7b5c558c5069b6efb1710c5888a0a2ad"
    
    //https://api.openweathermap.org/data/2.5/onecall?lat=33.441792&lon=-94.037689&lang=es&units=metric&exclude=minutely,alerts&appid=7b5c558c5069b6efb1710c5888a0a2ad
            
    
    // MARK: - init hourly
    
    var resourceClimaHourly: URL?

    
    init(hora: Int, latitud: Double, longitud: Double) {
        
        //http://api.openweathermap.org/data/2.5/onecall/timemachine?lat=60.99&lon=30.9&dt=1586468027&appid={API key}
        let resouceStringClima = "https://api.openweathermap.org/data/2.5/onecall?lat=\(String(describing: latitud))&lon=\(String(describing: longitud))&lang=es&units=metric&exclude=minutely,alerts&dt=\(hora)&appid=\(apiKey)"
        guard let resourceClima =  URL(string: resouceStringClima) else {fatalError()}
        self.resourceClimaHourly = resourceClima
        print(resouceStringClima)
    }
    
    // MARK: - func
    
    
    func getClimaHourly(completion: @escaping (Result<WeatherResponse, WeatherError>) -> Void )  {
        let dataTask = URLSession.shared.dataTask(with: resourceClimaHourly!) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.resourceNotFound))
                return
            }

            do {
                let decoder = JSONDecoder()
                let climaResponse = try decoder.decode(WeatherResponse.self, from: jsonData)
                
                completion(.success(climaResponse))
            } catch {
                completion(.failure(.invalidApiKey))
            }

        }
        dataTask.resume()
    }
    
    
    
    
}

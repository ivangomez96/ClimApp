//
//  ClimaRequest.swift
//  ClimApp
//
//  Created by Ivan on 16/11/2020.
//  Copyright © 2020 Ivan. All rights reserved.
//

import Foundation

enum ClimaError: Error {
    case invalidApiKey
    case resourceNotFound
}

struct ClimaRequest {
    
    let apiKey = "7b5c558c5069b6efb1710c5888a0a2ad"
    
    //http://api.openweathermap.org/data/2.5/weather?zip=1879,ar&lang=es&appid=7b5c558c5069b6efb1710c5888a0a2ad
    
    // MARK: - init
    
    var resourceClima: URL?

    init(zipCode: String) {
        
        let resouceStringClima = "http://api.openweathermap.org/data/2.5/weather?zip=\(zipCode),ar&units=metric&lang=es&appid=\(apiKey)"
        guard let resourceClima =  URL(string: resouceStringClima) else {fatalError()}
        self.resourceClima = resourceClima
    
    }
    
    func getClima(completion: @escaping (Result<ClimaResponse, ClimaError>) -> Void )  {
        let dataTask = URLSession.shared.dataTask(with: resourceClima!) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.resourceNotFound))
                return
            }

            do {
                let decoder = JSONDecoder()
                let climaResponse = try decoder.decode(ClimaResponse.self, from: jsonData)
               // let clima = climaResponse.weather
               // let weather = climaResponse.main
                
                completion(.success(climaResponse))
            } catch {
                completion(.failure(.invalidApiKey))
            }

        }
        dataTask.resume()
    }
    
    
    
    
}

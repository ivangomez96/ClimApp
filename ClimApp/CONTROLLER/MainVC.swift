//
//  ViewController.swift
//  ClimApp
//
//  Created by Ivan on 16/11/2020.
//  Copyright © 2020 Ivan. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let request = ClimaRequest(zipCode: "1879")
        request.getClima(){ [weak self] result in
            
            switch result {
                
                case .failure(let error):
                    print(error)
                    
            case .success(let clima):
                    print(clima)
            }
            
        }
        
    }
}

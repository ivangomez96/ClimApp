//
//  ViewController.swift
//  ClimApp
//
//  Created by Ivan on 16/11/2020.
//  Copyright © 2020 Ivan. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    // MARK: - VARIABLES


    // MARK: - UI
    
    private let headerAhoraLabel : UILabel = {
        let label = UILabel()
        label.text = "Ahora"
        label.textColor = .naranja1
        label.font = UIFont.headerFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ahoraView : UIView = {
        let view = UIView()
        view.backgroundColor = .naranja5
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descripcionLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .naranja2
        label.font = UIFont.captionFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperaturaLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .naranja1
        label.font = UIFont.temperaturaFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - LIFE CYCLES
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .naranja7
        requestInicial()
        
        //addsubviews
        view.addSubview(headerAhoraLabel)
        view.addSubview(ahoraView)
        ahoraView.addSubview(descripcionLabel)
        ahoraView.addSubview(temperaturaLabel)

    }
    
    override func viewDidLayoutSubviews() {
        
        agregarConstraints()
        
    }
    
    // MARK: - FUNC
    
    func requestInicial(){
        let request = ClimaRequest(zipCode: "1879")
        request.getClima(){ result in
            
            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let clima):
                print(clima)
                
                DispatchQueue.main.async {

                    self.temperaturaLabel.text =  "\(String(format: "%.0f", clima.main.temp))" + "°"
                    self.descripcionLabel.text = clima.weather.first?.weatherDescription.uppercased() as? String
                    
                }
                
            }
            
        }
    }
    
    func agregarConstraints(){
                
        headerAhoraLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        headerAhoraLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        headerAhoraLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true

        ahoraView.topAnchor.constraint(equalTo: headerAhoraLabel.bottomAnchor, constant: 24).isActive = true
        ahoraView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        ahoraView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        ahoraView.heightAnchor.constraint(equalToConstant: 160).isActive = true

        descripcionLabel.topAnchor.constraint(equalTo: ahoraView.topAnchor, constant: 16).isActive = true
        descripcionLabel.leftAnchor.constraint(equalTo: ahoraView.leftAnchor, constant: 16).isActive = true
        descripcionLabel.rightAnchor.constraint(equalTo: ahoraView.rightAnchor, constant: -16).isActive = true
        
        temperaturaLabel.topAnchor.constraint(equalTo: descripcionLabel.bottomAnchor).isActive = true
        temperaturaLabel.leftAnchor.constraint(equalTo: ahoraView.leftAnchor, constant: 16).isActive = true
        temperaturaLabel.rightAnchor.constraint(equalTo: ahoraView.rightAnchor, constant: -16).isActive = true
        
    }
    
    
    
}

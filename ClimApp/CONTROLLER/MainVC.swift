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
        label.textAlignment = .left
        label.textColor = .naranja1
        label.font = UIFont.headerFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let headerSubtituloLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .right
        label.textColor = .naranja3
        label.font = UIFont.captionFont
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
        label.font = UIFont.tagFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let sensacionLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .naranja2
        label.font = UIFont.captionFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let humedadLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .naranja1
        label.font = UIFont.bodyFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let headerDespuesLabel : UILabel = {
        let label = UILabel()
        label.text = "Después"
        label.textColor = .naranja1
        label.font = UIFont.headerFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackHsView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let cuatroHsView : UIView = {
        let view = UIView()
        view.backgroundColor = .naranja5
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let cuatroHsLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .naranja1
        label.font = UIFont.captionFont
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cuatroHsTemperaturaLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .naranja1
        label.font = UIFont.captionFont
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ochoHsView : UIView = {
        let view = UIView()
        view.backgroundColor = .naranja5
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let ochoHsLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .naranja1
        label.font = UIFont.captionFont
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ochoHsTemperaturaLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .naranja1
        label.font = UIFont.captionFont
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let doceHsView : UIView = {
        let view = UIView()
        view.backgroundColor = .naranja5
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let doceHsLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .naranja1
        label.font = UIFont.captionFont
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let doceHsTemperaturaLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .naranja1
        label.font = UIFont.captionFont
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    // MARK: - LIFE CYCLES
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .naranja7
        requestInicial()
        requestHourly()
        
        //addsubviews
    // ahora
        view.addSubview(headerAhoraLabel)
        view.addSubview(headerSubtituloLabel)
        view.addSubview(ahoraView)
        ahoraView.addSubview(descripcionLabel)
        ahoraView.addSubview(temperaturaLabel)
        ahoraView.addSubview(sensacionLabel)
        ahoraView.addSubview(humedadLabel)
    // despues
        view.addSubview(headerDespuesLabel)
        
        stackHsView.addArrangedSubview(cuatroHsView)
        cuatroHsView.addSubview(cuatroHsLabel)
        cuatroHsView.addSubview(cuatroHsTemperaturaLabel)

        stackHsView.addArrangedSubview(ochoHsView)
        ochoHsView.addSubview(ochoHsLabel)
        ochoHsView.addSubview(ochoHsTemperaturaLabel)

        stackHsView.addArrangedSubview(doceHsView)
        doceHsView.addSubview(doceHsLabel)
        doceHsView.addSubview(doceHsTemperaturaLabel)

        view.addSubview(stackHsView)

    }
    
    override func viewDidLayoutSubviews() {
        
        agregarConstraints()
        
    }
    
    // MARK: - FUNC
    
    private func requestInicial(){
//        let request = ClimaRequest()
//        request.getClima(){ result in
//
//            switch result {
//            case .failure(let error):
//                print(error)
//
//            case .success(let clima):
//                DispatchQueue.main.async {
//
//                }
//
//            }
//
//        }
    }
    
    
    
    private func requestHourly(){
        let request = ClimaRequest(hora: 1605733200)
        request.getClimaHourly(){ result in
            
            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let clima):
                DispatchQueue.main.async {
                    
                    //ahora
                    self.temperaturaLabel.text =  "\(String(format: "%.0f", clima.current.temp))°"
                    self.sensacionLabel.text =  "/ ST \(String(format: "%.0f", clima.current.feelsLike))°"
                    self.descripcionLabel.text = (clima.current.weather.first?.weatherDescription).map { $0.rawValue }?.uppercased()
                    self.humedadLabel.text = "Humedad: \(String(describing: clima.current.humidity))%"
                    
                    //despues
                    
                    let calculoHsSiguientes = self.calcularHsSiguientes(horaActual: Double(clima.current.dt))

                    self.cuatroHsLabel.text = "\(String(describing: calculoHsSiguientes[0])) hs."
                    self.ochoHsLabel.text = "\(String(describing: calculoHsSiguientes[1])) hs."
                    self.doceHsLabel.text = "\(String(describing: calculoHsSiguientes[2])) hs."
                    
                    self.cuatroHsTemperaturaLabel.text =  "\(String(format: "%.0f", clima.hourly[3].temp))°"
                    self.ochoHsTemperaturaLabel.text =  "\(String(format: "%.0f", clima.hourly[7].temp))°"
                    self.doceHsTemperaturaLabel.text =  "\(String(format: "%.0f", clima.hourly[11].temp))°"

                }
                
            }
            
        }
    }
    
    
    
    private func calcularHsSiguientes(horaActual: Double) -> [Int] {
        
        let horaEnCuatroHs = horaActual + 14400
        let horaEnOchoHs = horaActual + 28800
        let horaEnDoceHs = horaActual + 43200

        let dateEnCuatroHs = Date(timeIntervalSince1970: horaEnCuatroHs)
        let dateEnOchoHs = Date(timeIntervalSince1970: horaEnOchoHs)
        let dateEnDoceHs = Date(timeIntervalSince1970: horaEnDoceHs)

        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "UTC")!
        
        let hourCuatro = calendar.component(.hour, from: dateEnCuatroHs)
        let hourOcho = calendar.component(.hour, from: dateEnOchoHs)
        let hourDoce = calendar.component(.hour, from: dateEnDoceHs)

        
        return [hourCuatro, hourOcho, hourDoce]
    }

    
    
    func agregarConstraints(){
        
        //ahora
                
        headerAhoraLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        headerAhoraLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        headerAhoraLabel.rightAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        headerSubtituloLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        headerSubtituloLabel.leftAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerSubtituloLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true

        ahoraView.topAnchor.constraint(equalTo: headerAhoraLabel.bottomAnchor, constant: 24).isActive = true
        ahoraView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        ahoraView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        ahoraView.heightAnchor.constraint(equalToConstant: 160).isActive = true

        descripcionLabel.topAnchor.constraint(equalTo: ahoraView.topAnchor, constant: 16).isActive = true
        descripcionLabel.leftAnchor.constraint(equalTo: ahoraView.leftAnchor, constant: 16).isActive = true
        descripcionLabel.rightAnchor.constraint(equalTo: ahoraView.rightAnchor, constant: -16).isActive = true
        
        temperaturaLabel.topAnchor.constraint(equalTo: descripcionLabel.bottomAnchor).isActive = true
        temperaturaLabel.leftAnchor.constraint(equalTo: ahoraView.leftAnchor, constant: 16).isActive = true
        
        sensacionLabel.bottomAnchor.constraint(equalTo: temperaturaLabel.bottomAnchor, constant: -8).isActive = true
        sensacionLabel.leftAnchor.constraint(equalTo: temperaturaLabel.rightAnchor).isActive = true
        
        humedadLabel.bottomAnchor.constraint(equalTo: ahoraView.bottomAnchor, constant: -16).isActive = true
        humedadLabel.leftAnchor.constraint(equalTo: ahoraView.leftAnchor, constant: 16).isActive = true
        humedadLabel.rightAnchor.constraint(equalTo: ahoraView.rightAnchor, constant: -16).isActive = true
        
        //despues
        
        headerDespuesLabel.topAnchor.constraint(equalTo: ahoraView.bottomAnchor, constant: 24).isActive = true
        headerDespuesLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        headerDespuesLabel.rightAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        stackHsView.topAnchor.constraint(equalTo: headerDespuesLabel.bottomAnchor, constant: 24).isActive = true
        stackHsView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        stackHsView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        stackHsView.heightAnchor.constraint(equalToConstant: 128).isActive = true
        
        cuatroHsLabel.topAnchor.constraint(equalTo: cuatroHsView.topAnchor, constant: 16).isActive = true
        cuatroHsLabel.centerXAnchor.constraint(equalTo: cuatroHsView.centerXAnchor).isActive = true
        
        ochoHsLabel.topAnchor.constraint(equalTo: ochoHsView.topAnchor, constant: 16).isActive = true
        ochoHsLabel.centerXAnchor.constraint(equalTo: ochoHsView.centerXAnchor).isActive = true

        
        doceHsLabel.topAnchor.constraint(equalTo: doceHsView.topAnchor, constant: 16).isActive = true
        doceHsLabel.centerXAnchor.constraint(equalTo: doceHsView.centerXAnchor).isActive = true

        
        cuatroHsTemperaturaLabel.bottomAnchor.constraint(equalTo: cuatroHsView.bottomAnchor, constant: -16).isActive = true
        cuatroHsTemperaturaLabel.centerXAnchor.constraint(equalTo: cuatroHsView.centerXAnchor).isActive = true

        
        ochoHsTemperaturaLabel.bottomAnchor.constraint(equalTo: ochoHsView.bottomAnchor, constant: -16).isActive = true
        ochoHsTemperaturaLabel.centerXAnchor.constraint(equalTo: ochoHsView.centerXAnchor).isActive = true

        
        doceHsTemperaturaLabel.bottomAnchor.constraint(equalTo: doceHsView.bottomAnchor, constant: -16).isActive = true
        doceHsTemperaturaLabel.centerXAnchor.constraint(equalTo: doceHsView.centerXAnchor).isActive = true

        
        
    }
    
    
    
}

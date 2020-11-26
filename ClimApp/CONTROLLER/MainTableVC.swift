//
//  ViewController.swift
//  ClimApp
//
//  Created by Ivan on 16/11/2020.
//  Copyright © 2020 Ivan. All rights reserved.
//

import UIKit
import CoreLocation

class MainTableVC: UITableViewController, CLLocationManagerDelegate {
    
    // MARK: - VARIABLES

    let timestampAhora = NSDate().timeIntervalSince1970
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var latitudActual: Double?
    var longitudActual: Double?
        
    var climaActual: ClimaResponse? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - UI

    
    private let headerSubtituloLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .right
        label.textColor = .naranja3
        label.font = UIFont.bodyFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    
    // MARK: - LIFE CYCLES
    
    override init(style: UITableView.Style) {
        super.init(style: .grouped)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .naranja7
        tableView.register(AhoraCell.self, forCellReuseIdentifier: "AhoraCell")
        tableView.register(DespuesCell.self, forCellReuseIdentifier: "DespuesCell")
        tableView.register(SemanaCell.self, forCellReuseIdentifier: "SemanaCell")
        tableView.showsVerticalScrollIndicator = false
        
        requestLocation()
        requestHourly()
        
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    // MARK: - FUNC
    
    private func requestLocation(){
        
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            if locationManager.location != nil {
                latitudActual = locationManager.location?.coordinate.latitude
                longitudActual = locationManager.location?.coordinate.longitude
                fetchCityAndCountry(from: locationManager.location!) { city, country, error in
                    guard let city = city, let country = country, error == nil else { return }
                    self.headerSubtituloLabel.text = "\(city), \(country)"
                }
            }
        }
        
    }
    
    private func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,
                       placemarks?.first?.country,
                       error)
        }
    }
        
    
    private func requestHourly(){
    
        
        let request = ClimaRequest(hora: Int(timestampAhora), latitud: latitudActual!, longitud: longitudActual!)
        request.getClimaHourly(){ result in
            print(self.latitudActual!)
            print(self.longitudActual!)

            switch result {
            case .failure(let error):
                print(error)
                
            case .success(let clima):
                DispatchQueue.main.async {
                    
                    self.climaActual = clima



//                    //despues
//                    let calculoHsSiguientes = self.calcularHsSiguientes(horaActual: Double(clima.current.dt))
//                    self.cuatroHsLabel.text = "\(String(describing: calculoHsSiguientes[0])) hs."
//                    self.ochoHsLabel.text = "\(String(describing: calculoHsSiguientes[1])) hs."
//                    self.doceHsLabel.text = "\(String(describing: calculoHsSiguientes[2])) hs."
//
//                    self.cuatroHsTemperaturaLabel.text =  "\(String(format: "%.0f", clima.hourly[3].temp))°"
//                    self.ochoHsTemperaturaLabel.text =  "\(String(format: "%.0f", clima.hourly[7].temp))°"
//                    self.doceHsTemperaturaLabel.text =  "\(String(format: "%.0f", clima.hourly[11].temp))°"

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
        calendar.timeZone = TimeZone(identifier: "GMT-3")!
        
        let hourCuatro = calendar.component(.hour, from: dateEnCuatroHs)
        let hourOcho = calendar.component(.hour, from: dateEnOchoHs)
        let hourDoce = calendar.component(.hour, from: dateEnDoceHs)

        
        return [hourCuatro, hourOcho, hourDoce]
    }
    
    
    private func agregarConstraints(){
        
        
    }
    
    
        
    // MARK: - HEADER
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0,
                                              y: 0,
                                              width: tableView.bounds.size.width,
                                              height: 70))
        
        let headerLabel = UILabel(frame: CGRect(x: 24,
                                                y: 24,
                                                width: headerView.bounds.size.width,
                                                height: 12))
        
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.textAlignment = .left
        headerLabel.textColor = .naranja1
        headerLabel.font = UIFont.headerFont
        headerView.addSubview(headerLabel)
        
        return headerView
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        
        switch section {
            
        case 0: return "Ahora"
        case 1: return "Después"
        case 2: return "Semana"
        default: return ""
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            
        return 70
        
    }
    
    // MARK: - SECTIONS
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    
    // MARK: - ROWS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            
        case 0: return 1
        case 1: return 1
        case 2: return 7
        default: return 1
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
            
        case 0: return 160
        case 1: return 128
        default: return 42
            
        }
        
        
    }
        
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            let ahoraCell = tableView.dequeueReusableCell(withIdentifier: "AhoraCell", for: indexPath) as! AhoraCell
            if climaActual != nil {
                ahoraCell.setupAhoraCell(descripcion: "\(String(describing: climaActual!.current.weather.first!.weatherDescription.rawValue.uppercased()))",
                                        temperatura: "\(String(format: "%.0f", climaActual!.current.temp as! CVarArg))°",
                                        sensacion: "/ ST \(String(format: "%.0f", (climaActual?.current.feelsLike)! as CVarArg))°",
                                        humedad:"Humedad: \(String(describing: climaActual!.current.humidity))%")
            }
            return ahoraCell
            
            
        case 1:
            let despuesCell = tableView.dequeueReusableCell(withIdentifier: "DespuesCell", for: indexPath) as! DespuesCell
            if climaActual != nil {
                
                let calculoHsSiguientes = self.calcularHsSiguientes(horaActual: Double(climaActual!.current.dt))
                despuesCell.setupDespuesCell(cuatroHs: "\(String(describing: calculoHsSiguientes[0])) hs.",
                                            cuatroHsTemperatura: "\(String(format: "%.0f", climaActual!.hourly[3].temp))°",
                                             ochoHs:  "\(String(describing: calculoHsSiguientes[1])) hs.",
                                            ochoHsTemperatura: "\(String(format: "%.0f", climaActual!.hourly[7].temp))°",
                                             doceHs:  "\(String(describing: calculoHsSiguientes[2])) hs.",
                                            doceHsTemperatura: "\(String(format: "%.0f", climaActual!.hourly[11].temp))°")
            }
            return despuesCell
            
        case 2:
            let semanaCell = tableView.dequeueReusableCell(withIdentifier: "SemanaCell", for: indexPath) as! SemanaCell
            return semanaCell
            
        default:
            return UITableViewCell()
            
        }
        

    }
    
    
        
    
    
}

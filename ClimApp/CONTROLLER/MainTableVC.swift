//
//  MainTableVC.swift
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
    var ubicacion: String?
    
    var climaActual: WeatherResponse? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
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
        
        initialRequest()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        initialRequest()
        
    }
    
    // MARK: - FUNC
    
    private func initialRequest(){
        
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
                    self.ubicacion = "\(city), \(country)"
                }
                hourlyWeatherRequest()
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
        		
    
    private func hourlyWeatherRequest(){
    
        
        let request = WeatherRequest(hora: Int(timestampAhora), latitud: latitudActual!, longitud: longitudActual!)
        request.getClimaHourly(){ result in

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
    
    private func calcularDiasSiguientes(horaActual: Double) -> [Date] {
        
        let mañana = horaActual + 86400
        let pasadoMañana = horaActual + 172800
        let diaEnTresDias = horaActual + 259200
        let diaEnCuatroDias = horaActual + 345600
        let diaEnCincoDias = horaActual + 432000
        let diaEnSeisDias = horaActual + 518400
        let diaEnSieteDias = horaActual + 604800

        let dateMañana = Date(timeIntervalSince1970: mañana)
        let datePasadoMañana = Date(timeIntervalSince1970: pasadoMañana)
        let dateEnTresDias = Date(timeIntervalSince1970: diaEnTresDias)
        let dateEnCuatroDias = Date(timeIntervalSince1970: diaEnCuatroDias)
        let dateEnCincoDias = Date(timeIntervalSince1970: diaEnCincoDias)
        let dateEnSeisDias = Date(timeIntervalSince1970: diaEnSeisDias)
        let dateEnSieteDias = Date(timeIntervalSince1970: diaEnSieteDias)

        
        return [dateMañana, datePasadoMañana, dateEnTresDias, dateEnCuatroDias, dateEnCincoDias, dateEnSeisDias, dateEnSieteDias]
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
                                                width: headerView.bounds.size.width - 48,
                                                height: 12))
        
        let headerCiudadLabel = UILabel(frame: CGRect(x: 24,
                                                y: 24,
                                                width: headerView.bounds.size.width - 48,
                                                height: 12))
        
        headerCiudadLabel.textAlignment = .right
        headerCiudadLabel.textColor = .naranja3
        headerCiudadLabel.font = UIFont.bodyFont
        headerCiudadLabel.text = ubicacion?.uppercased()
        
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.textAlignment = .left
        headerLabel.textColor = .naranja1
        headerLabel.font = UIFont.headerFont
        headerView.addSubview(headerLabel)
            
        switch section {
        case 0:
            headerView.addSubview(headerCiudadLabel)
            return headerView
        default:
            return headerView
            
        }
                
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
                                        humedad:"Humedad: \(String(describing: climaActual!.current.humidity)) %")
            }
            return ahoraCell
            
            
        case 1:
            let despuesCell = tableView.dequeueReusableCell(withIdentifier: "DespuesCell", for: indexPath) as! DespuesCell
            if climaActual != nil {
                
                let calculoHsSiguientes = self.calcularHsSiguientes(horaActual: Double(climaActual!.current.dt))
                despuesCell.setupDespuesCell(cuatroHs: "A las \(String(describing: calculoHsSiguientes[0])) hs.",
                    cuatroHsTemperatura: "\(String(format: "%.0f", climaActual!.hourly[4].temp))°", cuatroHsIcon: climaActual!.hourly[3].weather.first!.icon,
                    ochoHs:  "A las \(String(describing: calculoHsSiguientes[1])) hs.",
                    ochoHsTemperatura: "\(String(format: "%.0f", climaActual!.hourly[7].temp))°",
                    doceHs:  "A las \(String(describing: calculoHsSiguientes[2])) hs.",
                    doceHsTemperatura: "\(String(format: "%.0f", climaActual!.hourly[11].temp))°")
            }
            return despuesCell
            
        case 2:
            let semanaCell = tableView.dequeueReusableCell(withIdentifier: "SemanaCell", for: indexPath) as! SemanaCell
            if climaActual != nil {
                let calculoDiasSiguientes = self.calcularDiasSiguientes(horaActual: Double(climaActual!.current.dt))
            //obtener nombre y numero de dia segun indexpath
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "cccc"
                dateFormatter.locale = Locale(identifier: "es_AR")
                let diaNombre = dateFormatter.string(from: calculoDiasSiguientes[indexPath.row])
                var calendar = Calendar.current
                calendar.timeZone = TimeZone(identifier: "GMT-3")!
                let diaNumero = calendar.component(.day, from: calculoDiasSiguientes[indexPath.row])

                semanaCell.setupSemanaCell(dia: "\(diaNombre.capitalized) \(diaNumero)", temperatura: "\(String(format: "%.0f", climaActual!.daily[indexPath.row].temp.min))° / \(String(format: "%.0f", climaActual!.daily[indexPath.row].temp.max))°")
                
            }
            return semanaCell
            
        default:
            return UITableViewCell()
            
        }
        

    }
    
    
        
    
    
}

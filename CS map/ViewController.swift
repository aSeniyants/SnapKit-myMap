//
//  ViewController.swift
//  CS map
//
//  Created by Аркадий Торвальдс on 23.06.2022.
//

import UIKit
import SnapKit
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let mapView : MKMapView = {
       let map = MKMapView()
        return map
    }()
    
    
    let NaviButtonConfig = UIImage.SymbolConfiguration(pointSize: 38)

    override func viewDidLoad() {
        setMapConstrains()
        setNavigateBottonConstrains()
        super.viewDidLoad()
    }

    @objc func buttonPush(sender: UIButton) {
        print("push")
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            checkLocationEnabled()
        }
    
    func setupManager(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }
    
    func chekAuthorization(){
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways:
                break
            case .authorizedWhenInUse:
                mapView.showsUserLocation = true
                locationManager.startUpdatingLocation()
                break
            case .denied:
                print("геолокация запрещена")
            case .restricted:
                break
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            }
        }
    
    func checkLocationEnabled(){
    //        проверяем включена ли служба геолокации
            if CLLocationManager.locationServicesEnabled(){
    //            если да, то запускаем сетапменеджер
                setupManager()
                chekAuthorization()
            }else{
    //        если нет, показываем алерт
                let alert = UIAlertController(title: "У вас включена ГПС", message: "Хотите включить?", preferredStyle: .alert)
                let settingsAction = UIAlertAction(title: "Настройки", style: .default) { (alert) in
                    if let url = URL(string: "App-Prefs:root=LOCATION_SERVICES"){
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
                let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
                alert.addAction(settingsAction)
                alert.addAction(cancelAction)
                present(alert, animated: true, completion: nil)
            }
        }

    
    func setMapConstrains() {
        view.addSubview(mapView)
        mapView.layer.borderColor = UIColor.red.cgColor
        mapView.layer.borderWidth = 5
        
        mapView.snp.makeConstraints{maker in
            maker.width.height.equalToSuperview()
        }
    }
    
    func setNavigateBottonConstrains() {
        let NavigateView = UIView()
        view.addSubview(NavigateView)
        NavigateView.layer.borderColor = UIColor.green.cgColor
        NavigateView.layer.borderWidth = 5
        NavigateView.snp.makeConstraints{maker in
            maker.right.equalTo(-5)
            maker.centerY.equalTo(self.view)
            maker.height.equalTo(215)
            maker.width.equalTo(50)
        }
        
        let buttonPlus = UIButton()
        buttonPlus.setImage(UIImage(systemName: "plus", withConfiguration: NaviButtonConfig)?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        buttonPlus.layer.cornerRadius = 25
        buttonPlus.backgroundColor = .white
        buttonPlus.addTarget(self, action: #selector(buttonPush), for: .touchUpInside)
        NavigateView.addSubview(buttonPlus)
        buttonPlus.snp.makeConstraints{maker in
            maker.right.equalTo(0)
            maker.height.width.equalTo(50)
        }
        
        let buttonMinus = UIButton()
        buttonMinus.setImage(UIImage(systemName: "minus", withConfiguration: NaviButtonConfig)?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        buttonMinus.layer.cornerRadius = 25
        buttonMinus.backgroundColor = .white
        buttonMinus.addTarget(self, action: #selector(buttonPush), for: .touchUpInside)
        NavigateView.addSubview(buttonMinus)
        buttonMinus.snp.makeConstraints{maker in
            maker.top.equalTo(buttonPlus.snp.bottom).offset(5)
            maker.right.equalTo(0)
            maker.height.width.equalTo(50)
        }

        let buttonLocation = UIButton()
        buttonLocation.setImage(UIImage(systemName: "location.north", withConfiguration: NaviButtonConfig)?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        buttonLocation.layer.cornerRadius = 25
        buttonLocation.backgroundColor = .white
        buttonLocation.addTarget(self, action: #selector(buttonPush), for: .touchUpInside)
        NavigateView.addSubview(buttonLocation)
        buttonLocation.snp.makeConstraints{maker in
            maker.top.equalTo(buttonMinus.snp.bottom).offset(5)
            maker.right.equalTo(0)
            maker.height.width.equalTo(50)
        }
        
        let buttonRec = UIButton()
        buttonRec.setImage(UIImage(systemName: "record.circle", withConfiguration: NaviButtonConfig)?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
        buttonRec.layer.cornerRadius = 25
        buttonRec.backgroundColor = .white
        buttonRec.addTarget(self, action: #selector(buttonPush), for: .touchUpInside)
        NavigateView.addSubview(buttonRec)
        buttonRec.snp.makeConstraints{maker in
            maker.top.equalTo(buttonLocation.snp.bottom).offset(5)
            maker.right.equalTo(0)
            maker.height.width.equalTo(50)
        }
        
        let buttonList = UIButton()
        buttonList.setImage(UIImage(systemName: "list.triangle", withConfiguration: NaviButtonConfig)?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        buttonList.layer.cornerRadius = 5
        buttonList.backgroundColor = .white
        buttonList.addTarget(self, action: #selector(buttonPush), for: .touchUpInside)
        view.addSubview(buttonList)
        buttonList.snp.makeConstraints{maker in
//            maker.top.equalTo(buttonRec.snp.bottom).offset(5)
            maker.right.equalTo(-5)
            maker.bottom.equalTo(-5)
            maker.height.width.equalTo(50)
        }
    }

}

extension ViewController {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last?.coordinate
        print(location)
    }
}

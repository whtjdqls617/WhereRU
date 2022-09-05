//
//  FindPlaceViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/04.
//

import UIKit
import CoreLocation
import MapKit

class FindPlaceViewController: UIViewController {
    
    let findPlaceView = FindPlaceView()
    
    let locationManager = CLLocationManager()
    
    var resultSearchController : UISearchController?
    
    override func loadView() {
        self.view = findPlaceView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationManager.locationManager.delegate = self
        LocationManager.locationManager.requestWhenInUseAuthorization()
        LocationManager.locationManager.startUpdatingLocation()
        findPlaceView.mapView.showsUserLocation = true
        findPlaceView.mapView.setUserTrackingMode(.follow, animated: true)
        
        let locationSearchTable = LoactionTableViewController()
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        navigationItem.searchController = resultSearchController // 서치바 생성
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
        
        locationSearchTable.mapView = findPlaceView.mapView
    }
    
}

extension FindPlaceViewController {
    func checkUserDeviceLocationServiceAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        //ios 14.0 이상이라면
        if #available(iOS 14.0, *){
            //인스턴스를 통해 locationManager가 가지고 있는 상태를 가져옴
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        //"iOS 위치서비스 활성화" 여부 체크 : locationServicesEnabled()
        if CLLocationManager.locationServicesEnabled(){
            //위치 서비스가 활성화돼 있으므로 위치권한 요청이 가능해서 위치 권한을 요청(3)
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치서비스가 꺼져있어 권한을 요청하지 못 합니다.")
        }
    }
    
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus){
        switch authorizationStatus {
        case .notDetermined:
            print("NotDetermined")
            //정확도 : kCLLocationAccuracy
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
            //앱을 사용하는 동안에 대한 위치 권한 요청, plist의 whenInUse 해줘야 -> request 메서드 사용 가능
            locationManager.requestWhenInUseAuthorization()
            
            //            locationManager.startUpdatingLocation() //제거가능
            
        case .restricted, .denied:
            print("Denied, 아이폰 설정으로 유도")
            //얼럿을 띄워 설정으로 유도
            showRequestLocationServiceAlert()
        case .authorizedWhenInUse:
            print("When In Use")
            //사용자가 위치를 허용해둔 상태라면, startUpdatingLocation을 통해 didUpdateLocations 메서드 실행
            locationManager.startUpdatingLocation()
        default: print("Default")
        }
    }
    
    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString){
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        present(requestLocationServiceAlert, animated: true, completion: nil)
    }
    
    func myLocation(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees, _ delta: Double) {
        let coordinateLocation = CLLocationCoordinate2DMake(latitude, longitude)
        let spanValue = MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta)
        let locationRegion = MKCoordinateRegion(center: coordinateLocation, span: spanValue)
        findPlaceView.mapView.setRegion(locationRegion, animated: true)
    }
    
}

extension FindPlaceViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last
        guard let latitude = currentLocation?.coordinate.latitude else {return}
        guard let longitude = currentLocation?.coordinate.longitude else {return}
        myLocation(latitude, longitude, 0.01)
    }
    
}

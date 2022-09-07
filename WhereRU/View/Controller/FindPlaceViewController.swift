//
//  FindPlaceViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/04.
//

import UIKit
import CoreLocation
import GoogleMaps
import GooglePlaces

class FindPlaceViewController: UIViewController {
    
    let findPlaceView = FindPlaceView()
    
    let locationManager = CLLocationManager()
    
    var resultSearchController : UISearchController?
    
    let locationSearchTable = GMSAutocompleteViewController()
    
    override func loadView() {
        self.view = findPlaceView
        
        let searchButton = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(pressSearchButton))
        navigationItem.rightBarButtonItem = searchButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        locationSearchTable.delegate = self
        locationSearchTable.modalPresentationStyle = .fullScreen
    }
    
    @objc func pressSearchButton() {
        present(locationSearchTable, animated: true)
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
}

extension FindPlaceViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//        print("Place name: \(String(describing: place.name))") //셀탭한 글씨출력
//        print(place.coordinate)
        findPlaceView.mapView.clear()
        let zoomCamera = GMSCameraUpdate.zoomIn()
        findPlaceView.mapView.animate(with: zoomCamera)
        let newPlace = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        
        let marker = GMSMarker(position: newPlace)
        marker.icon = UIImage(named: "custom_pin.png")
        marker.map = findPlaceView.mapView
        
        let newCamera = GMSCameraUpdate.setTarget(newPlace)
        findPlaceView.mapView.moveCamera(newCamera)
        
        dismiss(animated: true)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("bye")
        dismiss(animated: true)
    }
}

extension FindPlaceViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print(marker)
        return true
    }
}

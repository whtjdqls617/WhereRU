//
//  SelectPlaceModalViewController.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/29.
//

import UIKit

protocol SearchLocationDelegate {
    func sendInfoToFindPlace(_ destination : String?, _ latitude : Double, _ longitude : Double)
}

class SelectPlaceModalViewController: BaseViewController {
    
    let selectPlaceModalView = SelectPlaceModalView()
    
    var delegate : SearchLocationDelegate?
    
    var destination : String?
    var latitude : Double?
    var longitude : Double?
    
    override func loadView() {
        super.loadView()
        self.view = selectPlaceModalView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectPlaceModalView.selectButton.addTarget(self, action: #selector(pressSelectButton), for: .touchUpInside)
    }
    
    @objc func pressSelectButton() {
        let destination = self.destination
        let latitude = self.latitude ?? 0
        let longitude = self.longitude ?? 0
        delegate?.sendInfoToFindPlace(destination, latitude, longitude)
        dismiss(animated: true)
    }
}

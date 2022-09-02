//
//  FindPlaceView.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/02.
//

import UIKit

class FindPlaceView: UIView {

    let placeSearchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .white
        self.addSubview(placeSearchBar)

    }
    
    // MARK: AutoLayout
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            placeSearchBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            placeSearchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            placeSearchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            
        ])
    }
}

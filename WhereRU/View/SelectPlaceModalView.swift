//
//  SelectPlaceModalView.swift
//  WhereRU
//
//  Created by 조성빈 on 2022/09/29.
//

import UIKit

class SelectPlaceModalView: UIView {

    let placeNameLabel : UILabel = {
       let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let selectButton : UIButton = {
        let button = UIButton()
        button.setPreferredSymbolConfiguration(.init(pointSize: 50, weight: .regular, scale: .default), forImageIn: .normal)
        button.tintColor = .systemBlue
        button.setImage(UIImage(systemName: "arrowshape.turn.up.forward.circle.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        
        self.addSubview(placeNameLabel)
        self.addSubview(selectButton)
    }
    
    // MARK: AutoLayout
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            placeNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            placeNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            selectButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            selectButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
        
    }

}

//
//  PlayerCardCollectionViewCell.swift
//  TestingAppScrip
//
//  Created by Dheeraj Kumar Sharma on 27/12/21.
//

import UIKit

class PlayerCardCollectionViewCell: UICollectionViewCell {
    
    // MARK: PROPERTIES -
    
    let cardView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .gray.withAlphaComponent(0.4)
        v.layer.cornerRadius = 10
        return v
    }()
    
    let infoLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        l.textColor = .black
        l.numberOfLines = 0
        return l
    }()
    
    // MARK: MAIN -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: FUNCTIONS -
    
    func setUpViews(){
        addSubview(cardView)
        addSubview(infoLabel)
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardView.topAnchor.constraint(equalTo: topAnchor),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            infoLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            infoLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}

//
//  PlayerDetailViewController.swift
//  TestingAppScrip
//
//  Created by Dheeraj Kumar Sharma on 27/12/21.
//

import UIKit

class PlayerDetailViewController: UIViewController {

    // MARK: PROPERTIES -
    
    var playerData: Player?
    
    let infoLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .black
        l.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        l.numberOfLines = 0
        return l
    }()
    
    // MARK: MAIN -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
    }
    
    // MARK: FUNCTIONS -
    
    func setUpViews(){
        view.backgroundColor = .white
        view.addSubview(infoLabel)
        
        /// Setting up the info label
        guard let playerData = playerData else {
            return
        }
        
        infoLabel.text  =
        "PlayerName: \(playerData.name)(\(playerData.category))\nAge: \(playerData.age)\nCountry: \(playerData.country)\nBatting Style: \(playerData.battingStyle)"
        
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            infoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }

}

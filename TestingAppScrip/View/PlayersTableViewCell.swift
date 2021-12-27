//
//  PlayersTableViewCell.swift
//  TestingAppScrip
//
//  Created by Dheeraj Kumar Sharma on 27/12/21.
//

import UIKit

class PlayersTableViewCell: UITableViewCell {

    // MARK: PROPERTIES -
    
    var playerData: [Player]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var delegate: PlayerCardActionDelegate?
    
    lazy var collectionView: UICollectionView = {
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout.init())
        cv.setCollectionViewLayout(layout, animated: false)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(PlayerCardCollectionViewCell.self, forCellWithReuseIdentifier: "PlayerCardCollectionViewCell")
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = false
        cv.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        cv.delaysContentTouches = false
        return cv
    }()
    
    // MARK: MAIN -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: FUNCTIONS -
    
    func setUpViews(){
        backgroundColor = .white
        addSubview(collectionView)
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}

extension PlayersTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let playerData = playerData {
            return playerData.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerCardCollectionViewCell", for: indexPath) as! PlayerCardCollectionViewCell
        if let playerData = playerData {
            let data = playerData[indexPath.item]
            cell.infoLabel.text = "Name: \(data.name)\n(\(data.category))\nAge: \(data.age)\nBatting Style: \(data.battingStyle)"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let playerData = playerData {
            let data = playerData[indexPath.item]
            delegate?.didPlayerCardTapped(data)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
}

//
//  ViewController.swift
//  TestingAppScrip
//
//  Created by Dheeraj Kumar Sharma on 27/12/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: PROPERTIES -
    var teamData: [TeamPlayerModel]?
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.showsVerticalScrollIndicator = false
        tv.register(PlayersTableViewCell.self, forCellReuseIdentifier: "PlayersTableViewCell")
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView()
        tv.separatorStyle = .none
        return tv
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
        view.addSubview(tableView)
        teamData = Bundle.main.decode([TeamPlayerModel].self, from: "cricketTeam.json")
        
        /// Removing tableview section padding for iOS 15.0 +
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        navigationItem.title = "Cricket Teams"
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    // MARK: - ACTIONS -
    
    @objc func handleDropDown(button: UIButton){
        
        /// Tracking sections through button tags
        let section = button.tag
        let indexPath = IndexPath(row: 0, section: section)
        
        /// Changing the values in model for state change i.e. whether section expanded or not
        let isExpanded = self.teamData?[section].isExpanded ?? false
        self.teamData?[section].isExpanded = !isExpanded
        
        if isExpanded {
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else {
            tableView.insertRows(at: [indexPath], with: .fade)
        }
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let teamData = teamData {
            return teamData.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let teamData = teamData {
            if !teamData[section].isExpanded {
                return 0
            } else {
                return 1
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton()
        if let teamData = teamData {
            button.setTitle("\(teamData[section].team)", for: .normal)
        }
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(handleDropDown), for: .touchUpInside)
        button.tag = section
        return button
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersTableViewCell", for: indexPath) as! PlayersTableViewCell
        cell.selectionStyle = .none
        cell.contentView.isUserInteractionEnabled = false
        cell.delegate = self
        if let teamData  = teamData {
            cell.playerData = teamData[indexPath.section].players
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension ViewController: PlayerCardActionDelegate {
    
    func didPlayerCardTapped(_ data: Player) {
        let VC = PlayerDetailViewController()
        VC.playerData = data
        VC.navigationItem.title = data.name
        navigationController?.pushViewController(VC, animated: true)
    }

}


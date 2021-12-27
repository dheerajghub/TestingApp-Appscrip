//
//  TeamPlayerModel.swift
//  TestingAppScrip
//
//  Created by Dheeraj Kumar Sharma on 27/12/21.
//

import Foundation

struct TeamPlayerModel: Codable {
    let team: String
    let players: [Player]
    var isExpanded: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case team, players
    }
    
}

struct Player: Codable {
    let name: String
    let age: Int
    let country: String
    let battingStyle: String
    let category: String
}

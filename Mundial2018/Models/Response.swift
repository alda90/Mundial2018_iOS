//
//  Fixtures.swift
//  Mundial2018
//
//  Created by Aldair Carrillo on 28/05/21.
//  Copyright © 2021 Aldair. All rights reserved.
//

import Foundation

struct Response: Codable {
    var success: Bool
    var message: String?
    var fixtures: [Fixture]?
    var groups: [Group]?
    var standings: [Standings]?
    var stadiums: [Stadium]?

}

struct Fixture: Codable {
    var id: String
    var name: String
    var tournament: String?
    var matches: [Match]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, tournament, matches
    }
}

struct Match: Codable {
    var num: Int
    var date, time: String
    let team1, team2: Team
    var score1, score2, score1I, score2I: Int
    var score1et, score2et, score1p, score2p: Int?
    var goals1: [Goal]?
    var goals2: [Goal]?
    var group: String?
    var stadium: Stadium
    var city, timezone: String

    enum CodingKeys: String, CodingKey {
        case num, date, time, team1, team2, score1, score2
        case score1I = "score1i"
        case score2I = "score2i"
        case score1et, score2et, score1p, score2p
        case goals1, goals2, group, stadium, city, timezone
    }
}

struct Team: Codable {
    var id: String?
    var name: String
    var code: String
    var continent: String?
    var assoc: Association?
    var photo: String?
    var tournament: String?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, code, continent, assoc, photo, tournament
    }
}

struct Association: Codable {
    var key: String
    var name: String
    var continental: Confederation
}

struct Confederation: Codable {
    var name: String
    var code: String
}

struct Goal: Codable {
    var minute: Int
    var name: String
    var score1: Int
    var score2: Int
    var penalty: Bool?
    var offset: Int?
    var owngoal: Bool?
}

struct Stadium: Codable {
    var id: String?
    var key: String
    var name: String
    var capacity: Int?
    var city: String?
    var timezone: String?
    var photo: String?
    var tournament: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case key, name, capacity, city, timezone, photo, tournament
    }
}

struct Group: Codable {
    var id: String
    var name: String
    var tournament: String?
    var teams: [Team]
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, tournament, teams
    }
}

struct Standings: Codable {
    var id: String
    var name: String
    var standings: [Standing]
    var tournament: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, standings, tournament
    }
}

struct Standing: Codable {
    var team: Team
    var pos: Int
    var played: Int
    var won: Int
    var drawn: Int
    var lost: Int
    var goals_for: Int
    var goals_against: Int
    var pts: Int
}


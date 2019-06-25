//
//  Pokemon.swift
//  Pokedex
//
//  Created by julia rodriguez on 6/25/19.
//  Copyright © 2019 julia rodriguez. All rights reserved.
//

import Foundation

struct TopLevelDict: Decodable {
    private enum CodingKeys: String, CodingKey {
        case name
        case id
        case abilities
        case spritesDictionary = "sprites"
    }
    
    
    let name: String
    let id: Int
    let abilities: [AbilitiesDictionary]
    let spritesDictionary: SpritesDictionary
}

struct AbilitiesDictionary: Decodable {
    let ability: Ability
    struct Ability : Decodable {
        let name: String
      //let url: String
    }
}

struct SpritesDictionary: Decodable {
    let image: URL
    
    // CodingKeys - capitol C
    private enum CodingKeys: String, CodingKey {
        case image = "front_shiny"
    }
    
}

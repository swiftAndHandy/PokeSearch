//
//  Pokemon.swift
//  PokeSearch
//
//  Created by Andre Veltens on 15.11.25.
//

import Foundation
import SwiftData


@Model
class Pokemon: Codable {
    var abilities: [Ability]
    var baseExperience: Int
//    var cries: [Cry]
    var height: Int
    var id: Int
//    var sprites: [Sprite]
//    var stats: [Stat]
    
    enum CodingKeys: CodingKey {
        case abilities, base_experience, cries, height, id, sprites, stats
        
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        abilities = try container.decode([Ability].self, forKey: .abilities)
        baseExperience = try container.decode(Int.self, forKey: .base_experience)
        height = try container.decode(Int.self, forKey: .height)
        id = try container.decode(Int.self, forKey: .id)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(abilities, forKey: .abilities)
        try container.encode(baseExperience, forKey: .base_experience)
        try container.encode(height, forKey: .height)
        try container.encode(id, forKey: .id)
    }
}

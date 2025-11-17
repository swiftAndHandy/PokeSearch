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
    var name: String
    var sprites: Sprite
    var stats: [Stat]
    var elementTypes: [Element]
    
    enum CodingKeys: CodingKey {
        case abilities, base_experience, cries, height, id, name, sprites, stats, types
        
    }
    
    init(abilities: [Ability], baseExperience: Int, height: Int, id: Int, name: String, sprites: Sprite, stats: [Stat], elementTypes: [Element]) {
        self.abilities = abilities
        self.baseExperience = baseExperience
        self.height = height
        self.id = id
        self.name = name
        self.sprites = sprites
        self.stats = stats
        self.elementTypes = elementTypes
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        abilities = try container.decode([Ability].self, forKey: .abilities)
        baseExperience = try container.decode(Int.self, forKey: .base_experience)
        height = try container.decode(Int.self, forKey: .height)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        sprites = try container.decode(Sprite.self, forKey: .sprites)
        stats = try container.decode([Stat].self, forKey: .stats)
        elementTypes = try container.decode([Element].self, forKey: .types)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(abilities, forKey: .abilities)
        try container.encode(baseExperience, forKey: .base_experience)
        try container.encode(height, forKey: .height)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(sprites, forKey: .sprites)
        try container.encode(stats, forKey: .stats)
        try container.encode(elementTypes, forKey: .types)
    }
    
    static let example = Pokemon(abilities: [], baseExperience: 12, height: 10, id: 1, name: "bulbasaur", sprites: Sprite.example, stats: [], elementTypes: [Element(slot: 1, name: "grass", url: "https://pokeapi.co/api/v2/type/12/")])
}

//
//  Element.swift
//  PokeSearch
//
//  Created by Andre Veltens on 17.11.25.
//

import Foundation
import SwiftData

@Model
class Element: Codable {
    var slot: Int
    var name: String
    var url: String
    
    enum OuterKeys: CodingKey {
        case slot, type
    }
    
    enum InnerKeys: CodingKey {
        case name, url
    }
    
    init(slot: Int, name: String, url: String) {
        self.slot = slot
        self.name = name
        self.url = url
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: OuterKeys.self)
        let typeContainer = try container.nestedContainer(keyedBy: InnerKeys.self, forKey: .type)
        slot = try container.decode(Int.self, forKey: .slot)
        name = try typeContainer.decode(String.self, forKey: .name)
        url = try typeContainer.decode(String.self, forKey: .url)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: OuterKeys.self)
        var typeContainer = container.nestedContainer(keyedBy: InnerKeys.self, forKey: .type)
        try container.encode(slot, forKey: .slot)
        try typeContainer.encode(name, forKey: .name)
        try typeContainer.encode(url, forKey: .url)
    }
    
    enum ElementList: String, CaseIterable {
        case bug = "bug",
             dragon = "dragon",
             fairy = "fairy",
             fighting = "fighting",
             fire = "fire",
             flying = "flying",
             ghost = "ghost",
             grass = "grass",
             ground = "ground",
             ice = "ice",
             normal = "normal",
             poison = "poison",
             psychic = "psychic",
             steel = "steel",
             water = "water",
             unknown = "unknown"
    }
}

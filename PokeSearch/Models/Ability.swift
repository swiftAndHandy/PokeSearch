//
//  Ability.swift
//  PokeSearch
//
//  Created by Andre Veltens on 15.11.25.
//

import Foundation
import SwiftData

@Model class Ability: Codable {
    var name: String
    var url: String
    
    enum OuterKeys: CodingKey {
        case ability
    }
    
    enum InnerKeys: CodingKey {
        case name, url
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: OuterKeys.self)
        let abilityContainer = try container.nestedContainer(keyedBy: InnerKeys.self, forKey: .ability)
        name = try abilityContainer.decode(String.self, forKey: .name)
        url = try abilityContainer.decode(String.self, forKey: .url)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: OuterKeys.self)
        var abilityContainer = container.nestedContainer(keyedBy: InnerKeys.self, forKey: .ability)
        try abilityContainer.encode(name, forKey: .name)
        try abilityContainer.encode(url, forKey: .url)
    }
}

//
//  Stat.swift
//  PokeSearch
//
//  Created by Andre Veltens on 17.11.25.
//

import Foundation
import SwiftData

@Model
class Stat: Codable {
    var baseStat: Int
    var effort: Int
    var name: String
    
    enum OuterKeys: CodingKey {
        case base_stat, effort, stat
    }
    
    enum InnerKeys: CodingKey {
        case name
        case url
    }
    
    init(baseStat: Int, effort: Int, name: String) {
        self.baseStat = baseStat
        self.effort = effort
        self.name = name
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: OuterKeys.self)
        let statContainer = try container.nestedContainer(keyedBy: InnerKeys.self, forKey: .stat)
        
        baseStat = try container.decode(Int.self, forKey: .base_stat)
        effort = try container.decode(Int.self, forKey: .effort)
        name = try statContainer.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: OuterKeys.self)
        var statContainer = container.nestedContainer(keyedBy: InnerKeys.self, forKey: .stat)
        
        try container.encode(baseStat, forKey: .base_stat)
        try container.encode(effort, forKey: .effort)
        try statContainer.encode(name, forKey: .name)
    }
}

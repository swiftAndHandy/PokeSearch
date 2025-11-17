//
//  Types.swift
//  PokeSearch
//
//  Created by Andre Veltens on 17.11.25.
//

import Foundation
import SwiftData

@Model
class Types: Codable {
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
        
    }
    
    func encode(to encoder: any Encoder) throws {
        <#code#>
    }
}

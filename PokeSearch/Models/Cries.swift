//
//  Cries.swift
//  PokeSearch
//
//  Created by Andre Veltens on 20.02.26.
//

import Foundation
import SwiftData

@Model

class Cries: Codable {
    var latest: String?
    var legacy: String?
    
    enum CodingKeys: CodingKey {
        case latest, legacy
    }
    
    init(latest: String?, legacy: String?) {
        self.latest = latest
        self.legacy = legacy
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        latest = try container.decodeIfPresent(String.self, forKey: .latest)
        legacy = try container.decodeIfPresent(String.self, forKey: .legacy)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(latest, forKey: .latest)
        try container.encodeIfPresent(legacy, forKey: .legacy)
    }

    static let example = Cries(latest: "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/1.ogg",
                                legacy: "https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/legacy/1.ogg")
    
}

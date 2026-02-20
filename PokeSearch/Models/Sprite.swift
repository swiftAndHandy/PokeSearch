//
//  Sprite.swift
//  PokeSearch
//
//  Created by Andre Veltens on 15.11.25.
//

import Foundation
import SwiftData

@Model
class Sprite: Codable {
    var backDefault: String?
    var backFemale: String?
    var backShiny: String?
    var backShinyFemale: String?
    var frontDefault: String?
    var frontFemale: String?
    var frontShiny: String?
    var frontShinyFemale: String?
    
    enum CodingKeys: CodingKey {
        case back_default, back_female, back_shiny, back_shiny_female, front_default, front_female, front_shiny, front_shiny_female
    }
    
    init(backDefault: String?, backFemale: String?, backShiny: String?, backShinyFemale: String?, frontDefault: String?, frontFemale: String?, frontShiny: String?, frontShinyFemale: String?) {
        self.backDefault = backDefault
        self.backFemale = backFemale
        self.backShiny = backShiny
        self.backShinyFemale = backShinyFemale
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
    }
    
    required init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        backDefault = try container.decodeIfPresent(String.self, forKey: .back_default)
        backFemale = try container.decodeIfPresent(String.self, forKey: .back_female)
        backShiny = try container.decodeIfPresent(String.self, forKey: .back_shiny)
        backShinyFemale = try container.decodeIfPresent(String.self, forKey: .back_shiny_female)
        
        frontDefault = try container.decodeIfPresent(String.self, forKey: .front_default)
        frontFemale = try container.decodeIfPresent(String.self, forKey: .front_female)
        frontShiny = try container.decodeIfPresent(String.self, forKey: .front_shiny)
        frontShinyFemale = try container.decodeIfPresent(String.self, forKey: .front_shiny_female)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(backDefault, forKey: .back_default)
        try container.encodeIfPresent(backFemale, forKey: .back_female)
        try container.encodeIfPresent(backShiny, forKey: .back_shiny)
        try container.encodeIfPresent(backShinyFemale, forKey: .back_shiny_female)
        
        try container.encodeIfPresent(frontDefault, forKey: .front_default)
        try container.encodeIfPresent(frontFemale, forKey: .front_female)
        try container.encodeIfPresent(frontShiny, forKey: .front_shiny)
        try container.encodeIfPresent(frontShinyFemale, forKey: .front_shiny_female)
    }
    
    static let example = Sprite(backDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/1.png",
                                backFemale: "", backShiny: "", backShinyFemale: "",
                                frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
                                frontFemale: "", frontShiny: "", frontShinyFemale: "")
}

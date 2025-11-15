//
//  PokeAPI.swift
//  PokeSearch
//
//  Created by Andre Veltens on 15.11.25.
//

import Foundation

struct PokeAPI {
    static func fetchPokemon(id: Int) async throws -> Pokemon {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/1/")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        
        return try decoder.decode(Pokemon.self, from: data)
    }
}

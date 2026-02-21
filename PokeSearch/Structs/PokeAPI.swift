//
//  PokeAPI.swift
//  PokeSearch
//
//  Created by Andre Veltens on 15.11.25.
//

import Foundation

struct PokemonListEntry: Codable {
    let name: String
    let url: String
    
    var id: Int? {
        Int(url.split(separator: "/").last ?? "")
    }
}

struct PokemonListResponse: Codable {
    let count: Int
    let results: [PokemonListEntry]
}

extension PokemonListEntry {
    static let example = PokemonListEntry(name: "bulbasaur", url: "https://pokeapi.co/api/v2/pokemon/1/")
}

struct PokeAPI {
    static func fetchPokemon(id: Int) async throws -> Pokemon {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)/")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        
        return try decoder.decode(Pokemon.self, from: data)
    }
    
    static func fetchList() async throws -> PokemonListResponse {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=100000")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(PokemonListResponse.self, from: data)
    }
}

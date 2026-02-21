//
//  PokemonStorage.swift
//  PokeSearch
//
//  Created by Andre Veltens on 21.02.26.
//

import SwiftData

@Observable
class PokemonStorage {
    private var fetching: Set<Int> = []
    
    func fetchIfUncatched(id: Int, stored: [Int: Pokemon], context: ModelContext) async -> Pokemon? {
        if let stored = stored[id] {
            print("already stored: \(stored.name)")
            return stored
        }
        
        guard !fetching.contains(id) else { return nil }
        fetching.insert(id)
        defer { fetching.remove(id) }
        
        let fetched = try? await PokeAPI.fetchPokemon(id: id)
        
        if let fetched {
            context.insert(fetched)
        }
        
        print(fetched?.name ?? "not found")
        return fetched
        
    }
}

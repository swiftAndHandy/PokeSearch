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
    var error: AppError?
    
    func fetchIfUncatched(id: Int, stored: [Int: Pokemon], context: ModelContext) async -> Pokemon? {
        if let stored = stored[id] {
            return stored
        }
        
        guard !fetching.contains(id) else { return nil }
        fetching.insert(id)
        defer { fetching.remove(id) }
        
        do {
            let fetched = try await PokeAPI.fetchPokemon(id: id)
            context.insert(fetched)
            return fetched
        } catch {
            self.error = .networkError(error)
            return nil
        }
        
    }
}

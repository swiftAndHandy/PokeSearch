//
//  ContentView.swift
//  PokeSearch
//
//  Created by Andre Veltens on 15.11.25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Query(sort: \Pokemon.id) var pokeData: [Pokemon]
    @Environment(\.modelContext) private var modelContext
    
    @State private var pokemonList: [PokemonListEntry] = []
    @State private var selectedPokemon: Pokemon?
    @State private var searchFor: String = ""
    
    var filteredPokemonEntries: [PokemonListEntry] {
        if searchFor.isEmpty {
            return pokemonList
        }
        return pokemonList.filter {
            $0.name.localizedCaseInsensitiveContains(searchFor)
        }
    }
    
    var storedPokemon: [Int: Pokemon] {
        Dictionary(uniqueKeysWithValues: pokeData.map { ($0.id, $0) })
    }
    
    var body: some View {
        NavigationStack {
            PokemonListView(entries: filteredPokemonEntries, storedPokemon: storedPokemon) { pokemon in
                selectedPokemon = pokemon
            }
            .sheet(item: $selectedPokemon) { pokemon in
                PokemonDetailView(pokemon: pokemon)
            }
            .toolbar {
                TextField("Search for Pokémon", text: $searchFor)
                    .autocorrectionDisabled()
                    .padding(8)
                    .padding(.leading, 32)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.gray)
                                .padding(.leading, 8)
                            Spacer()
                        }
                    )
            }
            .task {
                if pokemonList.isEmpty {
                    pokemonList = (try? await PokeAPI.fetchList())?.results ?? []
                }
            }
        }
    }
    
//    private func fetchMissing() async {
//        do {
//            let storedIds = Set(pokeData.map { $0.id })
//            let list = try await PokeAPI.fetchList()
//            let missingIDs = list.results.compactMap { $0.id }.filter {
//                !storedIds.contains($0)
//            }
//            
//            for id in missingIDs {
//                let pokemon = try await PokeAPI.fetchPokemon(id: id)
//                modelContext.insert(pokemon)
//                print("downloaded \(pokemon.name)")
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
}

#Preview {
    ContentView()
}

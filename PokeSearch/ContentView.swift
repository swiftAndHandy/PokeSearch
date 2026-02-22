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
    @State private var storage = PokemonStorage()
    @State private var listLoadingError: AppError?
    @State private var networkErrorisPresent: Bool = false
    
    var filteredPokemonEntries: [PokemonListEntry] {
        if searchFor.isEmpty {
            return pokemonList
        }
        return pokemonList.filter {
            $0.name.localizedCaseInsensitiveContains(searchFor)
        }
    }
    
    var storedPokemon: [Int: Pokemon] {
        Dictionary(pokeData.map { ($0.id, $0) }, uniquingKeysWith: { first, _ in first })
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
                    do {
                        let list = try await PokeAPI.fetchList()
                        pokemonList = list.results.filter {
                            ($0.id ?? 0) < PokeAPI.officialPokedexLimit
                        }
                    } catch {
                        networkErrorisPresent = true
                        listLoadingError = .networkError(error)
                    }
                }
            }
            .alert("Error", isPresented: $networkErrorisPresent) {
                Button("Ok") {
                    listLoadingError = nil
                    networkErrorisPresent = false
                }
            } message: {
                Text(listLoadingError?.localizedDescription ?? "Unknown Error.")
            }
        }
        .environment(storage)
    }
}

#Preview {
    ContentView()
}

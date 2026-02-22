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
    @State private var searchFor: String = ""
    @State private var selectedPokemon: Pokemon?
    @State private var selectedType: String? = nil
    @State private var pokemonListByType: [PokemonListEntry] = []
    @State private var storage = PokemonStorage()
    @State private var listLoadingError: AppError?
    @State private var networkErrorisPresent: Bool = false
    
//    var filteredPokemonEntries: [PokemonListEntry] {
//        if searchFor.isEmpty {
//            return pokemonList
//        }
//        return pokemonList.filter {
//            $0.name.localizedCaseInsensitiveContains(searchFor)
//        }
//    }
    
    var filteredPokemonEntries: [PokemonListEntry] {
        let base = selectedType != nil ? pokemonListByType : pokemonList
        if searchFor.isEmpty { return base }
        return base.filter { $0.name.localizedCaseInsensitiveContains(searchFor) }
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
                ToolbarItem {
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
                
//                ToolbarItem(placement: .topBarTrailing) {
//                    Menu {
//                        Picker("Type", selection: $selectedType) {
//                            Text("All").tag(nil as String?)
//                            ForEach(PokemonType)
//                        }
//                    }
//                    
//                }
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
        .onChange(of: selectedType) { _, newType in
            pokemonListByType = []
            guard let newType else { return }
            Task {
                do {
                    pokemonListByType = try await PokeAPI.fetchList(type: newType)
                } catch {
                    networkErrorisPresent = true
                    listLoadingError = .networkError(error)
                }
            }
        }
        .environment(storage)
    }
}

#Preview {
    ContentView()
}

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
    
    @State var selectedPokemon: Pokemon?
    
    @State private var searchFor: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(pokeData, id: \.self) { pokemon in
                        Button("Show Details for \(pokemon.name.capitalized)") {
                            selectedPokemon = pokemon
                        }
                    }
                    Text("loading done")
                }
                .padding()
                .task {
                    await fetchMissing()
                }
            }
            .sheet(item: $selectedPokemon) { pokemon in
                PokemonDetailView(pokemon: pokemon)
            }
            .scrollBounceBehavior(.basedOnSize)
            .toolbar {
                    TextField("Search for Pokémon", text: $searchFor)
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
        }
    }
    
    private func fetchMissing() async {
        do {
            let storedIds = Set(pokeData.map { $0.id })
            let list = try await PokeAPI.fetchList()
            let missingIDs = list.results.compactMap { $0.id }.filter {
                !storedIds.contains($0)
            }
            
            for id in missingIDs {
                let pokemon = try await PokeAPI.fetchPokemon(id: id)
                modelContext.insert(pokemon)
                print("downloaded \(pokemon.name)")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

#Preview {
    ContentView()
}

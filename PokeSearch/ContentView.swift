//
//  ContentView.swift
//  PokeSearch
//
//  Created by Andre Veltens on 15.11.25.
//

import SwiftUI

struct ContentView: View {
    @State var pokeData: [Pokemon] = [Pokemon]()
    @State var selectedPokemon: Pokemon?
    
    @State private var searchFor: String = ""
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    ForEach(pokeData, id: \.self) { pokemon in
                        Button("Show Details for \(pokemon.name.capitalized)") {
                            selectedPokemon = pokeData[pokemon.id - 1]
                        }
                    }
                    Text("loading done")
                }
                .padding()
                .task {
                    do {
                        var result = try await PokeAPI.fetchPokemon(id: 1)
                        pokeData.append(result)
                        result = try await PokeAPI.fetchPokemon(id: 2)
                        pokeData.append(result)
                        result = try await PokeAPI.fetchPokemon(id: 3)
                        pokeData.append(result)
                        result = try await PokeAPI.fetchPokemon(id: 4)
                        pokeData.append(result)
                        result = try await PokeAPI.fetchPokemon(id: 5)
                        pokeData.append(result)
                        result = try await PokeAPI.fetchPokemon(id: 6)
                        pokeData.append(result)
                        result = try await PokeAPI.fetchPokemon(id: 7)
                        pokeData.append(result)
                        result = try await PokeAPI.fetchPokemon(id: 8)
                        pokeData.append(result)
                        result = try await PokeAPI.fetchPokemon(id: 9)
                        pokeData.append(result)
                    } catch {
                        print(error.localizedDescription)
                    }
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
}

#Preview {
    ContentView()
}

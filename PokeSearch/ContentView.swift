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
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            .sheet(item: $selectedPokemon) { pokemon in
                PokemonDetailView(pokemon: pokemon)
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}

#Preview {
    ContentView()
}

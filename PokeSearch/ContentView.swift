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
            VStack {
                if pokeData.count > 0 {
                    Button("Show Details") {
                        selectedPokemon = pokeData[0]
                        print(selectedPokemon?.name ?? "No Pokemon")
                    }
                }
            }
            .padding()
            .task {
                do {
                    let result = try await PokeAPI.fetchPokemon(id: 1)
                    pokeData.append(result)
                } catch {
                    
                }
            }
        }
        .sheet(item: $selectedPokemon) { pokemon in
            PokemonDetailView(pokemon: pokemon)
        }
    }
}

#Preview {
    ContentView(pokeData: [])
}

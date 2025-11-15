//
//  ContentView.swift
//  PokeSearch
//
//  Created by Andre Veltens on 15.11.25.
//

import SwiftUI

struct ContentView: View {
    @State var pokeData: Pokemon?
    
    var body: some View {
        VStack {
            if let pokemon = pokeData {
                Text(String(pokemon.baseExperience))
            }
        }
        .padding()
        .task {
            do {
                pokeData = try await PokeAPI.fetchPokemon(id: 1)
            } catch {
                
            }
        }
    }
}

#Preview {
    ContentView()
}

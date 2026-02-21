//
//  PokemonCryButtons.swift
//  PokeSearch
//
//  Created by Andre Veltens on 21.02.26.
//

import SwiftUI

struct PokemonCryButtons: View {
    private let pokemon: Pokemon
    
    var body: some View {
        VStack(alignment: .leading) {
            if pokemon.cries.legacy != nil {
                Button("Legacy", systemImage: "play.circle") {
                    Pokemon.playCry(for: pokemon, type: .legacy)
                }
                .buttonStyle(.bordered)
                .accessibilityLabel("Play legacy cry")
            }
            
            if pokemon.cries.latest != nil {
                Button("Latest", systemImage: "play.circle") {
                    Pokemon.playCry(for: pokemon, type: .latest)
                }
                .buttonStyle(.bordered)
                .accessibilityLabel("Play latest cry")
            }
        }
    }
    
    init(pokemon: Pokemon) {
        self.pokemon = pokemon
    }
}

#Preview {
    PokemonCryButtons(pokemon: Pokemon.example)
}

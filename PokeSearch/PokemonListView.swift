//
//  PokemonListView.swift
//  PokeSearch
//
//  Created by Andre Veltens on 15.11.25.
//

import SwiftUI

struct PokemonListView: View {
    let entries: [PokemonListEntry]
    let storedPokemon: [Int: Pokemon]
    var onSelect: (Pokemon) -> Void
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 140))]) {
                ForEach(entries, id: \.name) { entry in
                    PokemonCardView(entry: entry, storedPokemon: storedPokemon, onSelect: onSelect)
                }
            }
            .padding()
        }
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview {
    PokemonListView(
        entries: [.example],
        storedPokemon: [1: .example]
    ) {
        _ in
    }
}

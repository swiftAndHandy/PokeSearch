//
//  PokemonCardView.swift
//  PokeSearch
//
//  Created by Andre Veltens on 21.02.26.
//

import SwiftData
import SwiftUI

struct PokemonCardView: View {
    let entry: PokemonListEntry
    let storedPokemon: [Int: Pokemon]
    var onSelect: (Pokemon) -> Void
    
    @Environment(\.modelContext) private var modelContext
    @Environment(PokemonStorage.self) private var storage
    @State private var pokemon: Pokemon?
    
    var body: some View {
        Group {
            if let pokemon {
                Button {
                    onSelect(pokemon)
                } label: {
                    VStack {
                        AsyncImage(url: URL(string: pokemon.sprites.frontDefault ?? "")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                            } else {
                                Color.gray.opacity(0.2)
                            }
                        }
                        .frame(width: 120, height: 120)
                        
                        Text(pokemon.name.capitalized)
                            .font(.caption.bold())
                    }
                    .padding()
                    .background(.gray.opacity(0.1))
                    .clipShape(.rect(cornerRadius: 12))
                }
                .buttonStyle(.plain)
            } else {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.gray.opacity(0.1))
                    .frame(height: 130)
                    .overlay(ProgressView())
            }
        }
        .task {
            guard let id = entry.id else { return }
            pokemon = await storage.fetchIfUncatched(id: id, stored: storedPokemon, context: modelContext)
        }
    }
}

#Preview {
    PokemonCardView(
        entry: .example,
        storedPokemon: [1: .example]
    ) {
        _ in
    }
}

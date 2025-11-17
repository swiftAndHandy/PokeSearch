//
//  PokemonDetailView.swift
//  PokeSearch
//
//  Created by Andre Veltens on 15.11.25.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Text("\(pokemon.name.capitalized)")
                Spacer()
                Text("# \(pokemon.id)")
            }
            .padding()
            .background(Color.green.opacity(0.2))
            .clipShape(.capsule)
            .font(.title)
            AsyncImage(url: URL(string: pokemon.sprites.frontDefault ?? "https://invalid-url")) { phase in
                    if let image = phase.image {
                    image
                        .resizable()
                        .frame(width: 250, height: 250)
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("Error while loading image.")
                } else {
                    LoadingSpinner()
                }
            }
            Spacer()
            ForEach(pokemon.elementTypes) { element in
                Text("\(element.name)")
            }
            ForEach(pokemon.stats, id: \.self) { stat in
                Text("\(stat.name): \(stat.baseStat)")
            }
        }
    }
}

#Preview {
    PokemonDetailView(pokemon: Pokemon.example)
}

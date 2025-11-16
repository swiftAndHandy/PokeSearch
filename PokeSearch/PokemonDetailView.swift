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
            AsyncImage(url: URL(string: pokemon.sprites.frontDefault)) { phase in
                    if let image = phase.image {
                    image
                        .resizable()
                        .frame(width: 150, height: 150)
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("Error while loading image.")
                } else {
                    LoadingSpinner()
                }
            }
            Spacer()
            Text("Info-Box")
//                .frame(width: .infinity, height: 200)
        }
        .frame(width: 300, height: 500)
        .background(.ultraThinMaterial)
    }
}

#Preview {
    PokemonDetailView(pokemon: Pokemon.example)
}

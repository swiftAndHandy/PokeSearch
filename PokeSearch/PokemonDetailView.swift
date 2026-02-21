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
            
            
            HStack {
                AsyncImage(url: URL(string: pokemon.sprites.frontDefault ?? "https://invalid-url")) { phase in
                    
                    if let image = phase.image {
                        image
                            .resizable()
                            .frame(width: 250, height: 250)
                    } else if phase.error != nil {
                        Text("Error while loading image.")
                    } else {
                        LoadingSpinner()
                            .frame(width: 250, height: 250)
                    }
                }
                ElementView(for: pokemon.elementTypes)
                
            }
            .frame(maxWidth: .infinity)
            .background(.gray.opacity(0.2))
            .overlay(alignment: .topTrailing) {
                Button {
                    Pokemon.playCry(for: pokemon)
                } label: {
                    Image(systemName: "speaker.wave.2")
                        .resizable()
                        .foregroundStyle(.blue)
                        .frame(width: 25, height: 25)
                        .padding(8)
                        .background(Circle().foregroundStyle(.black.opacity(0.1)))
                }
                .accessibilityLabel("Play Cry")
                .padding()
                .padding(.trailing, 8)
            }
            
            Spacer()
            ForEach(pokemon.stats, id: \.self) { stat in
                Text("\(stat.name): \(stat.baseStat)")
            }
        }
        
    }
}

#Preview {
    PokemonDetailView(pokemon: Pokemon.example)
}

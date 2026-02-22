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
            .padding(.top, 40)
            .background(.gray.opacity(0.2))
            .overlay(alignment: .topTrailing) {
                PokemonCryButtons(pokemon: pokemon)
                    .padding()
            }
            
            Spacer()
//            ForEach(pokemon.stats, id: \.name) { stat in
//                Text("\(stat.name): \(stat.baseStat)")
//            }
            StatRadarView(stats: pokemon.stats)
        }
        
    }
}

#Preview {
    PokemonDetailView(pokemon: Pokemon.example)
}

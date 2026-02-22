//
//  PokemonDetailView.swift
//  PokeSearch
//
//  Created by Andre Veltens on 15.11.25.
//

import SwiftUI

struct PokemonDetailView: View {
    let pokemon: Pokemon
    
    @State private var showBack: Bool = false
    @State private var showShiny: Bool = false
    @State private var showFemale: Bool = false
    
    private var currentSprite: String? {
        switch (showBack, showShiny, showFemale) {
        case (false, false, false): return pokemon.sprites.frontDefault
        case(false, false, true): return pokemon.sprites.frontFemale
        case(false, true, false): return pokemon.sprites.frontShiny
        case(false, true, true): return pokemon.sprites.frontShinyFemale
        case(true, false, false): return pokemon.sprites.backDefault
        case(true, false, true): return pokemon.sprites.backFemale
        case(true, true, false): return pokemon.sprites.backShiny
        case(true, true, true): return pokemon.sprites.backShinyFemale
        }
    }
    
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
                AsyncImage(url: URL(string: currentSprite ?? "https://invalid-url")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                    } else if phase.error != nil {
                        Text("Error while loading image.")
                    } else {
                        LoadingSpinner()
                    }
                }
                .frame(width: 250, height: 250)
                
                ElementView(for: pokemon.elementTypes)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 40)
            .background(.gray.opacity(0.2))
            .overlay(alignment: .topLeading) {
                SpriteButtons(pokemon: pokemon, showFemale: $showFemale, showShiny: $showShiny, showBack: $showBack)
                .padding()
            }
            .overlay(alignment: .topTrailing) {
                PokemonCryButtons(pokemon: pokemon)
                    .padding()
            }
            
            Spacer()
            StatRadarView(stats: pokemon.stats)
        }
        
    }
}

#Preview {
    PokemonDetailView(pokemon: Pokemon.example)
}

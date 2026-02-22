//
//  SpriteButtons.swift
//  PokeSearch
//
//  Created by Andre Veltens on 22.02.26.
//

import SwiftUI

struct SpriteButtons: View {
    let pokemon: Pokemon
    @Binding var showFemale: Bool
    @Binding var showShiny: Bool
    @Binding var showBack: Bool
    
    var body: some View {
        HStack {
            if pokemon.sprites.frontShiny != nil || pokemon.sprites.backShiny != nil {
                Button(showShiny ? "Shiny" : "Regular", systemImage: "sparkles") {
                    showShiny.toggle()
                }
                .labelStyle(.iconOnly)
                .buttonStyle(.bordered)
                .tint(showShiny ? .orange : nil)
            }
            
            if pokemon.sprites.backDefault != nil {
                Button(showBack ? "Back" : "Front", systemImage: "arrow.trianglehead.2.counterclockwise.rotate.90") {
                    showBack.toggle()
                }
                .labelStyle(.iconOnly)
                .buttonStyle(.bordered)
                .tint(showBack ? .blue : nil)
            }
            
            if pokemon.sprites.frontFemale != nil || pokemon.sprites.backFemale != nil {
                Button(showFemale ? "♀" : "♂") {
                    showFemale.toggle()
                }
                .accessibilityLabel(showFemale ? "Show male version" : "Show female version")
                .font(.system(size: 16).bold())
                .buttonStyle(.bordered)
                .tint(showFemale ? .pink : nil)
            }
        }
    }
}

#Preview {
    SpriteButtons(pokemon: Pokemon.example,
                  showFemale: .constant(false),
                  showShiny: .constant(false),
                  showBack: .constant(false))
}

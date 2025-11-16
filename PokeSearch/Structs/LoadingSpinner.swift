//
//  LoadingSpinner.swift
//  PokeSearch
//
//  Created by Andre Veltens on 16.11.25.
//

import SwiftUI

struct LoadingSpinner: View {
    @State private var isSpinning = false
    
    var body: some View {
        Image("BallSpinner")
            .resizable()
            .frame(width: 75, height: 75)
            .rotationEffect(.degrees(isSpinning ? 360 : 0))
            .onAppear {
                isSpinning = true
            }
            .animation(
                .linear(duration: 2)
                    .repeatForever(autoreverses: false),
                value: isSpinning
            )
        Text("Loading…")
    }
}

#Preview {
    LoadingSpinner()
}

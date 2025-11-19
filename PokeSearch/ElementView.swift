//
//  ElementView.swift
//  PokeSearch
//
//  Created by Andre Veltens on 19.11.25.
//

import SwiftUI

struct ElementView: View {
    var elements: [Element]
    
    var body: some View {
        VStack(alignment: .center) {
            ForEach(elements) { element in
                ElementLabel(for: element.name)
            }
        }
    }
    
    init(elements: [Element]) {
        self.elements = elements
    }
}

#Preview {
    ElementView(elements: [Element(slot: 1, name: "fire", url: "http://error")])
}

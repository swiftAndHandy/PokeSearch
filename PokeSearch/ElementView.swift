//
//  ElementView.swift
//  PokeSearch
//
//  Created by Andre Veltens on 19.11.25.
//

import SwiftUI

struct ElementModifier: ViewModifier {
    var element: Element.ElementList
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(getForegroundStyle(for: element))
    }
    
    init(for element: Element.ElementList) {
        self.element = element
    }
    
    func getForegroundStyle(for element: Element.ElementList) -> Color {
        return Color.red
    }
}

extension View {
    func elementModifier(for element: Element.ElementList) -> some View {
        modifier(ElementModifier(for: element))
    }
}

struct ElementView: View {
    @State private var element: Element.ElementList
    @State private var text: String = ""
    
    var body: some View {
        Text("\(text)")
            .elementModifier(for: element)
    }
    
    init(for element: String) {
        self.text = element
        self.element = Element.ElementList(rawValue: element) ?? .unknown
    }
}

#Preview {
    ElementView(for: "fire")
}

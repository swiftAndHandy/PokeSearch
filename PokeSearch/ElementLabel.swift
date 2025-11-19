//
//  ElementLabel.swift
//  PokeSearch
//
//  Created by Andre Veltens on 19.11.25.
//

import SwiftUI

struct ElementModifier: ViewModifier {
    var element: Element.ElementList
    let style: ElementStyle
    
    struct ElementStyle {
        let foreground: Color?
        let background: Color?
    }
    
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .foregroundStyle(style.foreground ?? .primary)
            .background(style.background)
            .clipShape(.capsule)
    }
    
    init(for element: Element.ElementList) {
        self.element = element
        self.style = ElementModifier.getStyle(for: element)
    }
    
    static func getStyle(for element: Element.ElementList) -> ElementStyle {
        switch element {
        case .bug:
            return ElementStyle(foreground: .black, background: .green.opacity(0.7))
        case .dragon:
            return ElementStyle(foreground: .black, background: .teal)
        case .fairy:
            return ElementStyle(foreground: .white.opacity(1), background: .pink.opacity(0.75))
        case .fighting:
            return ElementStyle(foreground: .white, background: .brown)
        case .fire:
            return ElementStyle(foreground: .black, background: .orange)
        case .flying:
            return ElementStyle(foreground: .black, background: .cyan)
        case .ghost:
            return ElementStyle(foreground: .black, background: .gray.opacity(0.5))
        case .grass:
            return ElementStyle(foreground: .black, background: .green.opacity(0.9))
        case .ground:
            return ElementStyle(foreground: .black.opacity(0.9), background: .brown.opacity(0.8))
        case .ice:
            return ElementStyle(foreground: .black, background: .blue.opacity(0.4))
        case .normal:
            return ElementStyle(foreground: .black, background: .black.opacity(0.2))
        case .poison:
            return ElementStyle(foreground: .white, background: .purple.opacity(0.7))
        case .psychic:
            return ElementStyle(foreground: .white, background: .indigo.opacity(0.9))
        case .steel:
            return ElementStyle(foreground: .white, background: .gray.opacity(0.9))
        case .water:
            return ElementStyle(foreground: .black, background: .blue.opacity(0.5))
        case .unknown:
            return ElementStyle(foreground: .primary, background: .clear)
        }
    }
}

extension View {
    func elementModifier(for element: Element.ElementList) -> some View {
        modifier(ElementModifier(for: element))
    }
}

struct ElementLabel: View {
    @State private var element: Element.ElementList
    @State private var text: String = ""
    
    var body: some View {
        Text("\(text.capitalized)")
            .elementModifier(for: element)
    }
    
    init(for element: String) {
        self.text = element
        self.element = Element.ElementList(rawValue: element) ?? .unknown
    }
}

#Preview {
    ForEach(Element.ElementList.allCases, id: \.self) { element in 
        ElementLabel(for: element.rawValue)
    }
}

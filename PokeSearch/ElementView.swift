//
//  ElementView.swift
//  PokeSearch
//
//  Created by Andre Veltens on 19.11.25.
//

import SwiftUI

struct ElementModifier: ViewModifier {
    var element: Element.ElementList
    let style: ElementStyle
    
    struct ElementStyle {
        let foreground: Color
        let background: Color
    }
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(style.foreground)
    }
    
    init(for element: Element.ElementList) {
        self.element = element
        self.style = ElementModifier.getStyle(for: element)
    }
    
    static func getStyle(for element: Element.ElementList) -> ElementStyle {
        switch element {
        case .fire:
            return ElementStyle(foreground: .red, background: .yellow)
        default:
            return ElementStyle(foreground: .black, background: .white)
        }
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

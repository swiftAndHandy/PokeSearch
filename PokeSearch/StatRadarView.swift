//
//  StatRadarView.swift
//  PokeSearch
//
//  Created by Andre Veltens on 22.02.26.
//

import SwiftUI

struct StatRadarView: View {
    let stats: [Stat]
    
    private let statOrder = ["hp", "attack", "defense", "special-attack", "special-defense", "speed"]
    private let maxStatValue: Double = 180
    private let size: Double = 280
    private let offset: Double = 80
    
    private var sizeWithOffset: Double { size + offset }
    
    private var radius: Double { size / 2 }
    private var center: CGPoint { CGPoint(x: radius, y: radius) }
    
    private var orderedStats: [Stat] {
        statOrder.compactMap { name in stats.first { $0.name == name } }
    }
    
    private var radarPoints: [CGPoint] {
        orderedStats.enumerated().map { index, stat in
            point(index: index, value: Double(stat.baseStat))
        }
    }
    
    var body: some View {
        ZStack {
            ForEach([0.25, 0.5, 0.75, 1.0], id: \.self) { factor in
                RadarGridShape(count: statOrder.count, factor: factor)
                    .stroke(.gray.opacity(0.3), lineWidth: 3)
                    .frame(width: size, height: size)
            }
            
            RadarShape(points: radarPoints)
            .fill(.blue.opacity(0.3))
            .frame(width: size, height: size)
            
            RadarShape(points: radarPoints)
            .stroke(.blue, lineWidth: 2)
            .frame(width: size, height: size)
            
            ForEach(Array(statOrder.enumerated()), id: \.offset) { index, name in
                Text(name.uppercased())
                    .font(.system(size: 10, weight: .bold))
                    .offset(y: labelOffset(index: index))
                    .position(labelPosition(index: index))
            }
        }
        .frame(width: sizeWithOffset, height: sizeWithOffset)
    }
    
    private func point(index: Int, value: Double) -> CGPoint {
        let angle = (Double(index) / Double(statOrder.count)) * 2 * .pi - .pi / 2
        let distance = min((value / maxStatValue), 1.0) * radius
        return CGPoint(
            x: center.x + cos(angle) * distance,
            y: center.y + sin(angle) * distance
        )
    }
    
    private func labelPosition(index: Int) -> CGPoint {
        let angle = (Double(index) / Double(statOrder.count)) * 2 * .pi - .pi / 2
        let labelDistance = radius + 15 //+ extraPadding
        return CGPoint(
            x: (sizeWithOffset) / 2 + cos(angle) * labelDistance,
            y: (sizeWithOffset) / 2 + sin(angle) * labelDistance
        )
    }
    
    private func labelOffset(index: Int) -> Double {
        let angle = (Double(index) / Double(statOrder.count)) * 2 * .pi - .pi / 2
        let y = sin(angle)
        return y < -0.5 ? -8 : y > 0.5 ? 8 : 0
    }
}

struct RadarShape: Shape {
    let points: [CGPoint]
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        guard !points.isEmpty else { return path }
        path.move(to: points[0])
        points.dropFirst().forEach { path.addLine(to: $0) }
        path.closeSubpath()
        return path
    }
}

struct RadarGridShape: Shape {
    let count: Int
    let factor: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2 * factor
        
        for i in 0..<count {
            let angle = (Double(i) / Double(count)) * 2 * .pi - .pi / 2
            let point = CGPoint(
                x: center.x + cos(angle) * radius,
                y: center.y + sin(angle) * radius
            )
            
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        
        path.closeSubpath()
        return path
    }
}

#Preview {
    StatRadarView(stats: Pokemon.example.stats)
}

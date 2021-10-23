//
//  Pie.swift
//  Memorize Stanford CS193p
//
//  Created by karlis.stekels on 23/10/2021.
//

import SwiftUI


struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clokcwise: Bool = false
    
    func path(in rect: CGRect) -> Path {
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * CGFloat(cos(startAngle.radians)),
            y: center.y + radius * CGFloat(sin(startAngle.radians))
        )
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(center: center,
                 radius: radius,
                 startAngle: startAngle,
                 endAngle: endAngle,
                 clockwise: !clokcwise)
        p.addLine(to: center)
        return p
    }
        
}

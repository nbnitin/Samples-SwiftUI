//
//  InifinityShape.swift
//  Inifinity Shape
//
//  Created by Nitin Bhatia on 4/20/21.
//

import SwiftUI

struct InfinityShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX - 100, y: rect.midY + 72))
        path.addCurve(to: CGPoint(x: rect.midX - 100, y: rect.midY - 72), control1: CGPoint(x: rect.midX - 200, y: rect.midY + 72), control2: CGPoint(x: rect.midX - 200, y: rect.midY - 72))
        
        path.addCurve(to: CGPoint(x: rect.midX + 100, y: rect.midY + 72), control1: CGPoint(x: rect.midX, y: rect.midY - 72), control2: CGPoint(x: rect.midX, y: rect.midY + 72))
        
        path.addCurve(to: CGPoint(x: rect.midX + 100, y: rect.midY - 72), control1: CGPoint(x: rect.midX + 200, y: rect.midY + 72), control2: CGPoint(x: rect.midX + 200, y: rect.midY - 72))
        
        path.addCurve(to: CGPoint(x: rect.midX - 100, y: rect.midY + 72), control1: CGPoint(x: rect.midX, y: rect.midY - 72), control2: CGPoint(x: rect.midX, y: rect.midY + 72))
        
                return path
    }
    
    
}

struct InfinityShape_Previews: PreviewProvider {
    static var previews: some View {
        InfinityShape()
            .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round))
    }
}

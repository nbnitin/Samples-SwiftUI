//
//  Wave.swift
//  WaveAnimation
//
//  Created by Nitin Bhatia on 4/24/21.
//

import SwiftUI

struct Wave: Shape {

    // MARK:- variables
    var offset: Angle
        var percent: Double
        
        var animatableData: Double {
            get { offset.degrees }
            set { offset = Angle(degrees: newValue) }
        }
        
        func path(in rect: CGRect) -> Path {
            var p = Path()

            // empirically determined values for wave to be seen
            // at 0 and 100 percent
            let lowfudge = 0.02
            let highfudge = 0.98
            
            let newpercent = lowfudge + (highfudge - lowfudge) * percent
            let waveHeight = 0.015 * rect.height
            let yoffset = CGFloat(1 - newpercent) * (rect.height - 4 * waveHeight) + 2 * waveHeight
            let startAngle = offset
            let endAngle = offset + Angle(degrees: 360)
            
            p.move(to: CGPoint(x: 0, y: yoffset + waveHeight * CGFloat(sin(offset.radians))))
            
            for angle in stride(from: startAngle.degrees, through: endAngle.degrees, by: 5) {
                let x = CGFloat((angle - startAngle.degrees) / 360) * rect.width
                p.addLine(to: CGPoint(x: x, y: yoffset + waveHeight * CGFloat(sin(Angle(degrees: angle).radians))))
            }
            
            p.addLine(to: CGPoint(x: rect.width, y: rect.height))
            p.addLine(to: CGPoint(x: 0, y: rect.height))
            p.closeSubpath()
            
            return p
        }
}

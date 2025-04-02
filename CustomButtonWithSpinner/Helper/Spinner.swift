//
//  Spinner.swift
//  CustomButtonWithSpinner
//
//  Created by Nitin Bhatia on 27/03/25.
//

import SwiftUI

struct Spinner: View {
    var tintColor: Color
    var lineWidth: CGFloat = 4
    
    ///View properties
    @State private var rotation: Double = 0
    @State private var extraRotation: Double = 0
    @State private var isAnimatingTriggered: Bool = false
    var body: some View {
        ZStack {
            Circle()
                .stroke(tintColor.opacity(0.3), style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
            Circle()
                .trim(from: 0, to: 0.3)
                .stroke(tintColor, style: .init(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .rotationEffect(.init(degrees: rotation))
                .rotationEffect(.init(degrees: extraRotation))
        }
        .compositingGroup()
        .onAppear(perform: animate)
    }
    
    private func animate() {
        guard !isAnimatingTriggered else { return }
        isAnimatingTriggered = true
        
        withAnimation(.linear(duration: 0.7).speed(1.2).repeatForever(autoreverses: false)) {
            rotation += 360
            
        }
        
        withAnimation(.linear(duration: 1).speed(1.2)
            .delay(1)
            .repeatForever(autoreverses: false)) {
                extraRotation += 360
            
        }
    }
}

#Preview {
    Spinner(tintColor: .accentColor, lineWidth: 4)
        .frame(width: 30, height: 30)
}

//
//  ContentView.swift
//  ShineEffect
//
//  Created by Nitin Bhatia on 04/12/23.
//

import SwiftUI

struct ContentView: View {
    //view properties
    @State private var shineImage: Bool = false
    @State private var shineButton: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                
                Button("Shine Both elements") {
                    
                    shineButton.toggle()
                    shineImage.toggle()
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle(radius: 2))
                
                Spacer()
                
                Button("Share post", systemImage: "square.and.arrow.up"){
                    shineButton.toggle()
                    
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .shine(shineButton,duration: 0.8 ,clipShape: .capsule)
               
                Image("img", bundle: nil)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 150, height: 150)
                    .shine(shineImage, duration: 0.8 ,clipShape: .rect(cornerRadius: 20), rightToLeft: true)
                    .onTapGesture {
                        shineImage.toggle()
                    }
               
            }
            .navigationTitle("Shine Effect")
        } .padding()
    }
}

extension View {
    @ViewBuilder
    func shine(_ toggle: Bool, duration: CGFloat = 0.5, clipShape: some Shape = .circle, rightToLeft: Bool = false) -> some View {
        self
            .overlay(content: {
                GeometryReader {
                    let size = $0.size
                    //eliminating negative duration
                    let modeDuration = max(0.3, duration)
                    Rectangle()
                        .fill(.linearGradient(colors: [
                            .clear,
                            .clear,
                            .white.opacity(0.1),
                            .white.opacity(0.5),
                            .white.opacity(1),
                            .white.opacity(0.5),
                            .white.opacity(0.1),
                            .clear,
                            .clear
                            
                        ], startPoint: .leading, endPoint: .trailing))
                        .scaleEffect(y: 8)
                        .keyframeAnimator(initialValue: 0.0, trigger: toggle, content: {
                            content, progress in
                            content
                                .offset(x: -size.width + (progress * size.width * 2))
                        }, keyframes: {_ in
                            CubicKeyframe(.zero, duration: 0.1)
                            CubicKeyframe(1, duration: duration)
                        })
                        .rotationEffect(.init(degrees: 45))
                    //simply flipping the view in horizontal direction
                        .scaleEffect(x: rightToLeft ? -1 : 1)
                }
            })
        
            .clipShape(clipShape)
        //if you add scale effect here then image gets flipped
           // .scaleEffect(x: rightToLeft ? -1 : 1)
    }
}

#Preview {
    ContentView()
}

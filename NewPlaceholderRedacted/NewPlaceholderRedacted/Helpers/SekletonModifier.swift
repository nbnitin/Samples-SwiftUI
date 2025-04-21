//
//  SekletonModifier.swift
//  NewPlaceholderRedacted
//
//  Created by Nitin Bhatia on 20/04/25.
//

import SwiftUI

extension View {
    func skeleton(isRedacted: Bool) -> some View {
        self
            .modifier(SkeletonModifier(isRedacted: isRedacted))
    }
}

struct SkeletonModifier: ViewModifier {
    var isRedacted: Bool
    @State private var isAnimating: Bool = false
    @Environment(\.colorScheme) private var colorScheme
    func body(content: Content) -> some View {
        content
            .redacted(reason: isRedacted ? .placeholder : [])
            .overlay {
                if isRedacted {
                    GeometryReader {
                        let size = $0.size
                        let skeletonWidth = size.width / 2
                        let blurRadius = max(skeletonWidth/2, 30)
//                        let blurDiameter = blurRadius * 2
                        
                        let minX = -(skeletonWidth + blurRadius)
                        let maxX = size.width + (skeletonWidth + blurRadius)
                        
                        Rectangle()
                            .fill(colorScheme == .dark ? .white : .black)
                            .frame(width: skeletonWidth, height: size.height * 2)
                            .frame(height: size.height)
                            .blur(radius: blurRadius)
                            .rotationEffect(.init(degrees: rotation))
                            .offset(x: isAnimating ? maxX : minX)
                        
                    }
                    .mask {
                        content
                            .redacted(reason: .placeholder)
                    }
                    .blendMode(.softLight)
                    .task {
                        guard !isAnimating else { return }
                        withAnimation(animation) {
                            isAnimating = true
                        }
                    }
                    .onDisappear {
                        isAnimating = false
                    }
                    
                    .transaction {
                        if $0.animation != animation {
                            $0.animation = .none
                        }
                    }
                }
                
            }
        
    }
    
    var rotation: Double {
        return 5
    }
    
    var animation: Animation {
        .easeInOut(duration: 1.5).repeatForever(autoreverses: false)
    }
}

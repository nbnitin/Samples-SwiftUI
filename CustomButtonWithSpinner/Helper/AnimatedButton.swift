//
//  Untitled.swift
//  CustomButtonWithSpinner
//
//  Created by Nitin Bhatia on 27/03/25.
//

import SwiftUI

struct AnimatedButton: View {
    var config: Config
    var ontap: () async -> ()
    var shape: AnyShape = .init(.capsule)

    ///view properties
    @State private var isLoading = false
    var body: some View {
        Button {
            Task {
                isLoading = true
                await ontap()
                isLoading = false
            }
        } label: {
            HStack(spacing: 10) {
                if let symbolImage = config.symbolImage {
                    Image(systemName: symbolImage)
                        .font(.title3)
                        .transition(.blurReplace)
                    
                } else {
                    
                    if isLoading {
                        Spinner(tintColor: config.foregroundColor, lineWidth: 4)
                            .frame(width: 20, height: 20)
                    }
                }
                
                Text(config.title)
                    .contentTransition(.interpolate)
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, config.hPadding)
            .padding(.vertical, config.vPadding)
            .foregroundStyle(config.foregroundColor)
            .background(config.backgroundColor.gradient)
            .clipShape(shape)
            .contentShape(shape)
        }
        ///disabling button when task is performing
        .disabled(isLoading)
        
        .buttonStyle(ScaleButtonStyle())
        .animation(config.animation, value: config)
        .animation(config.animation, value: isLoading)
    }
    
    struct Config: Equatable {
        var title: String
        var foregroundColor: Color
        var backgroundColor: Color
        var symbolImage: String?
        var hPadding: CGFloat = 15
        var vPadding: CGFloat = 10
        var animation: Animation = .easeInOut(duration: 0.25)
    }
}

fileprivate struct ScaleButtonStyle: ButtonStyle {
 
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .animation(.linear(duration: 0.2)) {
                $0
                    .scaleEffect(configuration.isPressed ? 0.9 : 1)
            }
    }
    
    
}

#Preview {
    ContentView()
}

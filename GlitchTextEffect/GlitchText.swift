//
//  GlitchText.swift
//  GlitchText
//
//  Created by Nitin Bhatia on 11/06/24.
//

import SwiftUI

struct GlitchFrame : Animatable {
    
    var animatableData: AnimatablePair<CGFloat, AnimatablePair<CGFloat, AnimatablePair<CGFloat,CGFloat>>> {
        get {
            return .init(top, .init(center, .init(bottom, shadowOpacity)))
        }
        set {
            top = newValue.first
            center = newValue.second.first
            bottom = newValue.second.second.first
            shadowOpacity = newValue.second.second.second

        }
    }
    
    var top: CGFloat = 0
    var center: CGFloat = 0
    var bottom: CGFloat = 0
    var shadowOpacity:CGFloat = 0
}

//result handler
@resultBuilder
struct GlitchFrameBuilder {
    static func buildBlock(_ components: LinearKeyframe<GlitchFrame>...) -> [LinearKeyframe<GlitchFrame>] {
        return components
    }
}

struct GlitchText: View {
    var text: String
    var trigger: Bool
    var shadow: Color
    var radius: CGFloat
    var frames: [LinearKeyframe<GlitchFrame>]
    
    init(text: String, trigger: Bool, shadow: Color = .red, radius: CGFloat = 1, @GlitchFrameBuilder frames: @escaping () -> [LinearKeyframe<GlitchFrame>]) {
        self.text = text
        self.trigger = trigger
        self.shadow = shadow
        self.radius = radius
        self.frames = frames()
    }
    
    var body: some View {
        KeyframeAnimator(initialValue: GlitchFrame(), trigger: trigger) {value in
            ZStack {
                TextView(.top, offset: value.top, opacity: value.shadowOpacity)
                TextView(.center,offset: value.center, opacity: value.shadowOpacity)
                TextView(.bottom,offset: value.bottom, opacity: value.shadowOpacity)
            }
        } keyframes: { _ in
            for frame in frames {
                frame
            }
        }
    }
    
    @ViewBuilder
    func TextView(_ alignment: Alignment, offset: CGFloat, opacity: CGFloat) -> some View {
        Text(text)
            .mask({
                if alignment == .top {
                    VStack(spacing: 0, content: { //this will create mask view with 1/3 height without using geometry reader
                        Rectangle()
                        ExtendSpacer()
                        ExtendSpacer()
                    })
                } else if alignment == .center {
                    VStack(spacing: 0, content: { //this will create mask view with 1/3 height without using geometry reader
                        ExtendSpacer()
                        Rectangle()
                        ExtendSpacer()
                    })
                    
                } else {
                    VStack(spacing: 0, content: { //this will create mask view with 1/3 height without using geometry reader
                        ExtendSpacer()
                        ExtendSpacer()
                        Rectangle()
                    })
                }
            })
            .shadow(color: shadow.opacity(opacity), radius: radius, x: offset, y: offset / 2)
            .offset(x: offset)
    }
    
    @ViewBuilder
    func ExtendSpacer() -> some View {
        Spacer(minLength: 0)
            .frame(maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    ContentView()
}

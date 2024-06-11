//
//  ContentView.swift
//  GlitchText
//
//  Created by Nitin Bhatia on 11/06/24.
//

import SwiftUI

struct ContentView: View {
    @State private var shouldStart: Bool = false
    @State private var trigger: (Bool,Bool,Bool) = (false, false, false)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            GlitchTextFrame("Hello", trigger: trigger.0)
                .font(.system(size: 60, weight: .semibold))
            GlitchTextFrame("Hello Guys!", trigger: trigger.1)
                .font(.system(size: 40, design: .rounded))
            
            GlitchTextFrame("This is glitch text effect!", trigger: trigger.2)
                .font(.system(size: 20))
            
            
            Button(action: {
                Task{
                    while(shouldStart) {
                        trigger.0.toggle()
                        try? await Task.sleep(for: .seconds(0.6))
                        trigger.1.toggle()
                        try? await Task.sleep(for: .seconds(0.9))
                        trigger.2.toggle()
                        try? await Task.sleep(for: .seconds(0.12))
                    }
                }
                shouldStart.toggle()
            }, label: {
                Text(shouldStart ? "Stop" : "Trigger")
                    .padding(.horizontal, 15)
            })
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .tint(.black)
        }
        .padding(.top, 20)
    }
    
    @ViewBuilder
    func GlitchTextFrame(_ text: String, trigger: Bool) -> some View {
        ZStack {
            GlitchText(text: text, trigger: trigger){
                LinearKeyframe(
                    GlitchFrame(top: 0,center:-5 ,bottom:0 , shadowOpacity:1),
                    duration: 0.1
                )
                LinearKeyframe(GlitchFrame(top: -4.21, center: 3.56, bottom: 8.23, shadowOpacity: 0.72), duration: 0.1)
                LinearKeyframe(GlitchFrame(top: 6.34, center: -2.45, bottom: -7.89, shadowOpacity: 0.65), duration: 0.1)
                LinearKeyframe(GlitchFrame(top: -9.87, center: 1.23, bottom: 4.56, shadowOpacity: 0.90), duration: 0.1)
                LinearKeyframe(GlitchFrame(top: 0.12, center: -3.45, bottom: 9.67, shadowOpacity: 0.35), duration: 0.1)
                LinearKeyframe(GlitchFrame(top: 5.67, center: -6.78, bottom: 2.34, shadowOpacity: 0.57), duration: 0.1)
                LinearKeyframe(GlitchFrame(), duration: 0.1)
                
            }
            
            GlitchText(text: text, trigger: trigger, shadow: .green){
                LinearKeyframe(
                    GlitchFrame(top: 0,center:-5 ,bottom:0 , shadowOpacity:1),
                    duration: 0.1
                )
                LinearKeyframe(GlitchFrame(top: -4.21, center: 3.56, bottom: 8.23, shadowOpacity: 0.72), duration: 0.1)
                LinearKeyframe(GlitchFrame(top: 6.34, center: -2.45, bottom: -7.89, shadowOpacity: 0.65), duration: 0.1)
                LinearKeyframe(GlitchFrame(top: -9.87, center: 1.23, bottom: 4.56, shadowOpacity: 0.90), duration: 0.1)
                LinearKeyframe(GlitchFrame(top: 0.12, center: -3.45, bottom: 9.67, shadowOpacity: 0.6), duration: 0.1)
                LinearKeyframe(GlitchFrame(top: 5.67, center: -6.78, bottom: 2.34, shadowOpacity: 0.4), duration: 0.1)
                LinearKeyframe(GlitchFrame(), duration: 0.1)
                
            }
            
        }
    }
}

#Preview {
    ContentView()
}

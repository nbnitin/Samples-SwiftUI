//
//  ContentView.swift
//  SliderTicks
//
//  Created by Nitin Bhatia on 31/01/26.
//

//this code will work for device plus any views brightness.

import SwiftUI

struct ContentView: View {
    @State private var brightnessAmount: Double = 0
    private let minValue: Double = 0.0
    private let maxValue: Double = 1.0
    private let step: Double = 0.1
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        VStack {
            Text("Brightened Text")
                .font(.title)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .brightness(brightnessAmount) //its brightnes by x not set brightness to x that why its increasing towards 0 and decresing towards 1
            
            Slider(value: $brightnessAmount, in: minValue...maxValue, step: step) {
                Text("Brightness")
            }
            .onChange(of: brightnessAmount) { _, newValue in
                setScreenBrightness(to: newValue)
            }
        }
        .padding()
    }
    
    //This functions works on real device only
    func setScreenBrightness(to value: CGFloat) {
        // Value should be between 0.0 and 1.0
        currentScreen()?.brightness = CGFloat(value)
    }
    

    func currentScreen() -> UIScreen? {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first?
            .screen
    }
}

#Preview {
    ContentView()
}

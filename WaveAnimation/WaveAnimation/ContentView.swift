//
//  ContentView.swift
//  WaveAnimation
//
//  Created by Nitin Bhatia on 4/24/21.
//

import SwiftUI

struct ContentView: View {
    @State private var waveOffset = Angle(degrees: 0)
    @State private var percent = 50.0
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        VStack {
            CircleWave(percent: Int(self.percent))
            Slider(value: self.$percent, in: 0...100)
        }
        .padding(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

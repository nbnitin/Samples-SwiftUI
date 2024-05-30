//
//  ContentView.swift
//  FlipClockTimerEffect
//
//  Created by Nitin Bhatia on 30/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var timer : CGFloat = 0
    @State private var count : Int = 0
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 4, content: {
                    FlipClockTimerView(value: .constant(count / 10), size: CGSize(width: 100, height: 150), fontSize: 70, foreground: .white, background: .red, cornerRadius: 20)
                    FlipClockTimerView(value: .constant(count % 10), size: CGSize(width: 100, height: 150), fontSize: 70, foreground: .white, background: .red, cornerRadius: 20)
                })
            }
            .padding()
            .onReceive(Timer.publish(every: 0.01, on: .current, in: .common).autoconnect(), perform: { _ in
                timer += 0.01
                
                if timer >= 60 {timer = 0}
                count = Int(timer)
            })
        }
    }
}

#Preview {
    ContentView()
}

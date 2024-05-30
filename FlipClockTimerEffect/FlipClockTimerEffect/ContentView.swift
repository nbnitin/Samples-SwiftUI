//
//  ContentView.swift
//  FlipClockTimerEffect
//
//  Created by Nitin Bhatia on 30/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var timer = Timer.publish(every: 0.01, on: .current, in: .common).autoconnect()
    @State private var timerCount : CGFloat = 0
    @State private var count : Int = 0
    var body: some View {
        NavigationStack {
            VStack {
                HStack(spacing: 4, content: {
                    FlipClockTimerView(value: .constant(count / 10), size: CGSize(width: 100, height: 150), fontSize: 70, foreground: .white, background: .red, cornerRadius: 20)
                    FlipClockTimerView(value: .constant(count % 10), size: CGSize(width: 100, height: 150), fontSize: 70, foreground: .white, background: .red, cornerRadius: 20)
                })
                Text("Timer for 20 seconds")
                    .padding(.top)
            }
            .padding()
            
            .onReceive(timer, perform: { _ in
                timerCount += 0.01
                
                if timerCount >= 60 {timerCount = 0}
                count = Int(timerCount)
                
                if count / 10 == 20 {
                    timer.upstream.connect().cancel()
                }
            })
        }
    }
}

#Preview {
    ContentView()
}

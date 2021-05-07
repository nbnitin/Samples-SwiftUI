//
//  CircleWave.swift
//  WaveAnimation
//
//  Created by Nitin Bhatia on 4/27/21.
//

import SwiftUI

struct CircleWave: View {
    var percent : Int = 0
    @State var waveOffset = Angle(degrees: 10)
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Text("\(self.percent)%")
                    .foregroundColor(.black)
                    .font(Font.system(size: 0.25 * min(geo.size.width, geo.size.height) ))
                Circle()
                    .stroke(Color.blue, lineWidth: 0.025 * min(geo.size.width, geo.size.height))
                    .overlay(
                        Wave(offset: Angle(degrees: self.waveOffset.degrees), percent: Double(percent)/100)
                            .fill(Color(red: 0, green: 0.5, blue: 0.75, opacity: 0.5))
                            .clipShape(Circle().scale(0.92))
                    )
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .onAppear {
            withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)) {
                self.waveOffset = Angle(degrees: 360)
            }
        }
    }
}

struct CircleWave_Previews: PreviewProvider {
    static var previews: some View {
        CircleWave()
    }
}

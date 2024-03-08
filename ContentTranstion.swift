//
//  ContentView.swift
//  ContentTransitionDemo
//
//  Created by Nitin Bhatia on 09/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var value : Int = 0
    @State var sfImage: String = "house.fill"
    @State var sfCount : Int = 1
    var body: some View {
        VStack {
            
            Image(systemName: sfImage)
                .font(.largeTitle.bold())
                .contentTransition(.symbolEffect(.automatic))
            Button(action: {
                let images : [String] = ["suit.heart.fill","house.fill","gearshape","person.circle.fill","iphone","macbook"]
                withAnimation(
                    .bouncy){
                        sfCount += 1
                        sfImage = images[sfCount % images.count]
                    }
            }, label: {
                Text("Update Image")
            })
            .padding(.bottom, 10)
           Text("$\(value)")
                .contentTransition(.numericText(value: Double(value)))
            
            Button(action: {
                withAnimation(
                    
                ) {
                    value = .random(in: 1000 ... 1000000)
                }
            }, label: {
                Text("Update")
            })
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

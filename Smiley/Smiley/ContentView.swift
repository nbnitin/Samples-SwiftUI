//
//  ContentView.swift
//  Smiley
//
//  Created by Nitin Bhatia on 4/22/21.
//

import SwiftUI

struct ContentView: View {
    let range : ClosedRange<CGFloat> = -120 ... 140
    @State var val : CGFloat = 0
    
    
    @State private var location: CGPoint = CGPoint(x: 50, y: 50) // 1
    
    

    var body: some View {
        VStack{
            SmileyView(yOffset: val)
                .stroke(Color.black,lineWidth: 3)
                .frame(height:500)
                .background(Color.green)
            
            Slider(value: $val, in: range)
           
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

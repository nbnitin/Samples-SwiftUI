//
//  ContentView.swift
//  ShapeMorphingAnimation
//
//  Created by Nitin Bhatia on 04/07/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MorphingView()
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

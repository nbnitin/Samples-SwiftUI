//
//  ContainerBackground.swift
//  UsefulModifiers
//
//  Created by Nitin Bhatia on 31/05/25.
//

//This allows us to  modify the backgrounds of the navigation and navigation split views, which  could be useful in certain situations

//This available in iOS 18+
import SwiftUI

struct ContainerBackground: View {
    var body: some View {
        NavigationStack {
            Text("Hello, World!")
                
                .navigationTitle("Container Background")
                .containerBackground(.clear, for: .navigation)
        }
        
        .background(.red)
    }
}

#Preview {
    ContainerBackground()
}

//
//  ContainerRelativeFrame.swift
//  UsefulModifiers
//
//  Created by Nitin Bhatia on 31/05/25.
//


//This allows us to dynamically adjust the size of the view based on the container or nearest view

import SwiftUI

struct ContainerRelativeFrame: View {
    var body: some View {
        Rectangle()
            .fill(.purple)
            .containerRelativeFrame(.vertical) { length, axis in
                return length * 0.3
               }
        Rectangle()
            .fill(.purple)
            .containerRelativeFrame(.vertical, alignment: .center) { length, axis in
                return length * 0.3
               }
        
        Rectangle()
            .fill(.green)
            .containerRelativeFrame(.horizontal, alignment: .center) { length, axis in
                return length * 0.1
               }
        Rectangle()
            .fill(.green)
            .containerRelativeFrame(.horizontal, alignment: .center) { length, axis in
                return length * 0.2
               }
        
        Rectangle()
            .fill(.red)
            .containerRelativeFrame([.horizontal, .vertical]) { length, axis in
                return length * 0.3
               }
    }
}

#Preview {
    ContainerRelativeFrame()
}

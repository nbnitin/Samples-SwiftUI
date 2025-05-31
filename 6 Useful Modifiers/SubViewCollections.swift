//
//  SubViewCollections.swift
//  UsefulModifiers
//
//  Created by Nitin Bhatia on 31/05/25.
//

//This allows us to extract the subviews from a given  content and gives us  in a "SubViewCollection" format.

//With this we can create more complicated user interfaces

import SwiftUI

struct SubViewCollections: View {
    var body: some View {
        let customContent = ForEach(0...10,id:\.self ) {_ in
            Rectangle()
        }
            
        Group(subviews: customContent) {collection in
            Text("The views are: \(collection.count)")
        }
    }
}

#Preview {
    SubViewCollections()
}

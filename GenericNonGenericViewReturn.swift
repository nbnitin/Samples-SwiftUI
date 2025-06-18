//
//  ContentView.swift
//  Pull To Search
//
//  Created by Nitin Bhatia on 17/06/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack() {
            Text("Hello, world!")
                .frame(maxWidth: .infinity, alignment: .leading)
            giveMeSomeViews() {
                Button (action: {
                    print(123)
                }){
                    Text("button")
                }
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            giveMeSomeViews(Text("sssfff"))
            
            
                .frame(maxHeight: .infinity, alignment: .top)
                .padding()
        }
    }
}

@ViewBuilder
//generic any type of view
func giveMeSomeViews<Content: View>(@ViewBuilder content: () -> Content) -> some View {
    Text("Hello")
    Text("World")
    content()
}

@ViewBuilder
//non generic restrict to only Text
func giveMeSomeViews(_ content: Text) -> some View {
    content
}

#Preview {
    ContentView()
}

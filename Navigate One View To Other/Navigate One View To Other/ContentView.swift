//
//  ContentView.swift
//  Navigate One View To Other
//
//  Created by Nitin on 15/05/20.
//  Copyright © 2020 Nitin. All rights reserved.
//

import SwiftUI

struct Products : Identifiable {
    var id = UUID()
    var name : String = ""
}



struct ContentView: View {
    @State var items : [Products] = [Products]()
    @State var count : Int = 0
    
    
    var body: some View {
        NavigationView{
            VStack{
                List(items){i in
                    NavigationLink(destination: DetailView(item: i)) {                     HStack{
                        Text(i.name)
                    }
                    }
                }
                Button(action: {
                    self.count = self.count + 1
                    print(self.count)
                    self.items.append(Products(name: " Hello \(self.count)"))
                }) {
                    Text("Add")
                }
                Text("Current Count \(self.count)")
            }
        .navigationBarTitle("Products")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

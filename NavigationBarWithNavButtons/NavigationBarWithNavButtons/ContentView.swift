//
//  ContentView.swift
//  NavigationBarWithNavButtons
//
//  Created by Nitin on 19/05/20.
//  Copyright © 2020 Nitin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            Text("Hello, World!")
                .navigationBarTitle("Sample",displayMode: .inline)
            
                .navigationBarItems(leading:
                    HStack{
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                        Text("Add")
                        
                    }
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                            Text("Add 2t")
                            
                        }
                    }
                    ,trailing:
                        HStack{
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                                Text("Add")
                                
                            }
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                          Image(systemName: "heart")
                            }
                }
                )
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

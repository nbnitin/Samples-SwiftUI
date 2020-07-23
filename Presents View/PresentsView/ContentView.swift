//
//  ContentView.swift
//  SampleSwiftUI
//
//  Created by Nitin on 08/05/20.
//  Copyright © 2020 Nitin. All rights reserved.
//

import SwiftUI

struct Products : Identifiable {
    var id = UUID()
    var name : String
}


struct ContentView: View {
    
    //Observer leads to change, means if there is change in variable then its sends internal notification to elements which are using this variable and ask them to refresh it.
    @ObservedObject var postFetcher = PostsFetcher()
    
    //@state is local variable if you want dynamic value or need to change value of a variable then use @state
    @State var showDetails = false
    @State private var items : Posts?
    
    var body: some View {
       
        //list is like a table view which repeats loop over given variable
            List(postFetcher.posts) { items in
                //HStack is horizontal stack view
                HStack {
                    VStack(alignment: .leading){
                            Text(items.title).font(.headline)
                            
                            Text(items.body).font(.subheadline)
                            
                    }
                  
                    //this is tap gesture on list
                }.onTapGesture {
                    self.showDetails.toggle()
                    self.items = items
                }
                    
                //this helps to present given view, we are sending value to next view in this constructor
                
                //right now swift ui has no way to present view in full screen, swift ui works from iOS 13 and iOS 13 deufalt is to present screen like with space from top.
                }.sheet(isPresented: $showDetails){
                DetailView(details: self.items!)
        }
            
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

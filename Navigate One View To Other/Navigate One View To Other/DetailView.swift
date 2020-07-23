//
//  DetailView.swift
//  Navigate One View To Other
//
//  Created by Nitin on 15/05/20.
//  Copyright © 2020 Nitin. All rights reserved.
//

import SwiftUI



struct DetailView: View {
    @State var item : Products!
    
    
    
    var body: some View {
        VStack{
            Text("Id: \(item.id)")
            Text("Product Name:  \(item.name)")

        }
    }
    
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}

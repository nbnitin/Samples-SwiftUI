//
//  DetailView.swift
//  SampleSwiftUI
//
//  Created by Nitin on 10/05/20.
//  Copyright © 2020 Nitin. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    //dynamic variable which value been set from content view
    @State var details : Posts
    
    var body: some View {
        VStack{
            Text(details.title)
            Text(details.body)
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}

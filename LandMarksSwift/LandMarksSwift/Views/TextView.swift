//
//  TextView.swift
//  PracticeSwiftUI
//
//  Created by Nitin Bhatia on 15/09/22.
//

import SwiftUI

struct TextView: View {
    var title: String
    var subTitle : String
    var place : String
    var body: some View {
        
        VStack(alignment:.leading) {
                Text(title)
                    .font(.title)
                .foregroundColor(.black)
                HStack {
                    Text(subTitle)
                        .font(.subheadline)
                    Spacer()
                    Text(place)
                        .font(.subheadline)
                    
                }
            }
        .padding()
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView(title: "hh", subTitle: "hh", place: "hh")
    }
}

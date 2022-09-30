//
//  LandMarkRowView.swift
//  PracticeSwiftUI
//
//  Created by Nitin Bhatia on 15/09/22.
//

import SwiftUI

struct LandMarkRowView: View {
    var landmark : Landmark
    
    var body: some View {
        
        HStack() {
            landmark.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(landmark.name)
        }
    }
}

struct LandMarkRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LandMarkRowView(landmark: landmarks[0])
                        .previewLayout(.fixed(width: 300, height: 70))
            LandMarkRowView(landmark: landmarks[1])
                        .previewLayout(.fixed(width: 300, height: 70))
                }
    }
}

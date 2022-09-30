//
//  LearnWithVideo.swift
//  TabBar
//
//  Created by Nitin Bhatia on 23/09/22.
//

import SwiftUI

struct LearnWithVideo: View {
    var body: some View {
        VStack {
            VStack {
                Image("Image")
                    .resizable()
                    .frame(width: 24,height: 28)
            }
            .frame(width: 81,height: 81)
            .background(Color(red: 0.957, green: 0.961, blue: 1))
            .clipShape(Circle())
            Text("Polity")
               
        }
    }
}

struct LearnWithVideo_Previews: PreviewProvider {
    static var previews: some View {
        LearnWithVideo()
    }
}

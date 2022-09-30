//
//  VideoThumbnailView.swift
//  TabBar
//
//  Created by Nitin Bhatia on 26/09/22.
//

import SwiftUI

struct VideoThumbnailView: View {
    var body: some View {
        
        
        
        ZStack() {
            Image("Image")
                .resizable()
            
            VStack(alignment: .leading,spacing: 74) {
                HStack {
                    Text("Disaster")
                        .foregroundColor(.red)
                        .font(.system(size: 12))
                        .padding(.leading,20)
                    Spacer()
                }
                HStack(spacing: 16) {
                    Text("Disaster Disaster")
                        .foregroundColor(.red)
                        .font(.system(size: 20))
                        .padding(.leading,20)
                    Spacer()
                    Image(systemName: "play.fill")
                        .foregroundColor(Color.red)
                        .padding(.trailing,20)
                }
                
            }

        }
        .frame(width: 288,height: 162)
    }
}

struct VideoThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        VideoThumbnailView()
    }
}

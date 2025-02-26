//
//  ContentView.swift
//  Samples
//
//  Created by Nitin Bhatia on 22/02/25.
//

import SwiftUI



struct ContentView: View {
    @State var scale: CGFloat = 1.0
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: "https://picsum.photos/i/237/400/400")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if phase.error != nil {
                    Text("No image available")
                } else {
                    Image(systemName: "photo")
                }
            }
            .frame(width: 250, height: 250)
            .border(Color.gray)
            
            AsyncImage(url: URL(string: "https://picsum.photos/id/237/400/400")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if phase.error != nil {
                    Text("No image available")
                } else {
//                    Image(systemName: "photo")
                    ProgressView()
                }
            }
            .frame(width: 250, height: 250)
            
            
            CacheAsyncImage(url: URL(string: "https://picsum.photos/id/234/400/400")!) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } else if phase.error != nil {
                    Text("No image available")
                } else {
//                    Image(systemName: "photo")
                    ProgressView()
                }
            }
            .frame(width: 250, height: 250)
        }
    }
}



#Preview {
    ContentView()
}

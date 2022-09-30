//
//  ContentView.swift
//  PracticeSwiftUI
//
//  Created by Nitin Bhatia on 15/09/22.
//

import SwiftUI

struct ContentView: View {
    var landMarks : Landmark
    
    var body: some View {
        
        VStack {
            MapView(coordinate: landMarks.locationCoordinate)
                //.ignoresSafeArea(edges : .top)
                .frame(height: 300)
            
            CircleImageView(img: landMarks.image)
                .offset(y: -130)
                .padding(.bottom, -130)
            VStack(alignment: .leading) {
                
                Text(landMarks.name)
                    .font(.title)
                
                HStack {
                    Text(landMarks.park)
                    Spacer()
                    Text(landMarks.state)
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                
                Divider()
                
                
                Text("About \(landMarks.name)")
                    .font(.title2)
                Spacer(minLength: 2)
                Text(landMarks.description).font(.body).fontWeight(.thin)
                
                
            }
            .padding()
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(landMarks: landmarks[0])
    }
}

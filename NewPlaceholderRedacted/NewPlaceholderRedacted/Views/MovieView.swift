//
//  MovieView.swift
//  NewPlaceholderRedacted
//
//  Created by Nitin Bhatia on 04/04/25.
//

import SwiftUI

struct MovieView: View {
    var isLoading = true
    
    var body: some View {
        VStack {
            Group {
                if isLoading {
                    // Placeholder rectangle
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.3))
                        .frame(height: 400)
                        .padding(.horizontal)
                } else {
                    //becuase .readacted not works with static image
                    // Actual image
                    Image("download")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 400)
                        .padding(.horizontal)
                }
            }
            Text("Jungle Book")
                .font(.largeTitle)
                .foregroundStyle(.white)
                .padding()
            
            HStack(alignment: .bottom, spacing: 20) {
                Image(systemName: "hand.thumbsup")
                    .foregroundColor(.white)
                    .font(.system(size: 22))
                Image(systemName: "hand.thumbsdown")
                    .foregroundColor(.white)
                    .font(.system(size: 22))
                Spacer()
                Image(systemName: "plus.circle")
                    .foregroundColor(.white)
                    .font(.system(size: 22))
                Image(systemName: "heart")
                    .foregroundColor(.white)
                    .font(.system(size: 22))
            }
            .padding()
            
            Button(action: {}, label: {
                Text("Read More")
                    .foregroundColor(.white)
                    .font(.headline)
            })
            .frame(maxWidth: .infinity)
            .padding(.all, 20)
            .background(RoundedRectangle(cornerRadius: 30).fill(Color.blue))
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Among the leaves where wild things grow, A boy walks paths the grown don’t know. With panther’s grace and bear’s delight, He learns to run, to dream, to fight. The jungle hums—his soul’s true light.")
                .foregroundColor(.white)
                .font(.body)
                .padding(10)
        }
        
    }
}

#Preview {
    ContentView()
}

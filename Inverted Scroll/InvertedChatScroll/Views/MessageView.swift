//
//  MessageView.swift
//  InvertedChatScroll
//
//  Created by Nitin Bhatia on 07/07/24.
//

import SwiftUI

struct MessageView: View {
    
    let text: String
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundStyle(.white)
                .padding()
                .background(.blue)
                .clipShape(
                    RoundedRectangle(cornerRadius: 16)
                )
                .overlay(alignment: .bottomLeading) {
                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.title)
                        .rotationEffect(.degrees(45))
                        .offset(x: -10, y: 10)
                        .foregroundStyle(.blue)
                }
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    MessageView(text: "Hello, World!")
}

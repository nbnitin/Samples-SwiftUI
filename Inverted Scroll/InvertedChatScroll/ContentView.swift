//
//  ContentView.swift
//  InvertedChatScroll
//
//  Created by Nitin Bhatia on 07/07/24.
//

import SwiftUI

struct ContentView: View {
    var chatView = ChatView()
    var body: some View {
        VStack{
            chatView
            HStack(spacing: 30) {
                Button("Load More", action: {
                    chatView.chatData.loadMoreData()
                })
                .padding()
                .background(Color(red: 0, green: 0, blue: 0.5))
                .clipShape(.buttonBorder)
                Button("Add New", action: {
                    chatView.addNewMessage()
                })
                .padding()
                .background(Color(red: 0, green: 0, blue: 0.5))
                .clipShape(.buttonBorder)

            }
        }
        
    }
}

#Preview {
    ContentView()
}

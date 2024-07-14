//
//  ChatiView.swift
//  InvertedChatScroll
//
//  Created by Nitin Bhatia on 07/07/24.
//

import SwiftUI
import Combine

class ChatData: ObservableObject {
    @Published var data: [Int] = (0...20).map { $0 }
    var lastAppendedData : Int? = nil

    func loadMoreData() {
        guard data.count < 40 else { return }
        let additionalData = (21...40).map { $0 }
        data.append(contentsOf: additionalData)
    }

    func addNewMessage() {
        var lastData = 0
        if let lastAppendedData {
           lastData = getRandomNumber()
            
        } else {
            lastData = (data.last ?? 0) + 1
        }
        data.insert(lastData, at: 0)
        lastAppendedData = lastData
    }
    
    private func getRandomNumber() -> Int {
       let num =  (41 ... 100000).randomElement()!
        if data.contains(num) {
            return getRandomNumber()
        }
        return num
    }
}

struct ChatView: View {
    
    @ObservedObject var chatData: ChatData = ChatData()

    var body: some View {
        
        ScrollViewReader { scrollView in
            List(chatData.data, id: \.self) { int in
                MessageView(text: "\(int)")
                    .flippedUpsideDown()
                    .listRowSeparator(.hidden)
                    .id(int)
                    .onAppear {
                        if int == chatData.data.last {
                            chatData.loadMoreData()
                        }
                    }
            }
            .listStyle(.plain)
            .flippedUpsideDown()
            .onAppear {
                scrollView.scrollTo(chatData.data.first!)
            }
        }
    }
    
 
    
     func addNewMessage() {
         chatData.addNewMessage()
    }
}

struct FlippedUpsideDown: ViewModifier {
    func body(content: Content) -> some View {
        content
            .rotationEffect(.radians(Double.pi))
            .scaleEffect(x: -1, y: 1, anchor: .center)
    }
}

extension View {
    func flippedUpsideDown() -> some View {
        modifier(FlippedUpsideDown())
    }
}

#Preview {
    ChatView()
}

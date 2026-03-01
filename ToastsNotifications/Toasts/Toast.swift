//
//  Toast.swift
//  ToastNotification
//
//  Created by Nitin Bhatia on 28/02/26.
//

import SwiftUI


import SwiftUI

struct Toast: Identifiable, Equatable {
    let id = UUID()                  // Unique ID
    var type: ToastStyle
    var title: String
    var message: String
    var duration: Double = 10          // Auto-dismiss
    var actionView: ActionView?
    var position: ToastPosition = .bottom
}

struct ActionView: View, Equatable {
    var text: String = "Action"
    var onPress: () -> Void = { }
    var body: some View {
        Text(text)
            .font(.system(size: 12))
            .foregroundColor(.blue)
            .onTapGesture(perform: onPress)
    }
    
    static func == (lhs: ActionView, rhs: ActionView) -> Bool {
        lhs.text == rhs.text
    }
}


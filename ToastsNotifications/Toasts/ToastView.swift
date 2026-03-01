//
//  ToastView.swift
//  ToastNotification
//
//  Created by Nitin Bhatia on 28/02/26.
//

import SwiftUI

struct ToastView: View {
    var type: ToastStyle
    var title: String
    var message: String
    var actionView: ActionView? = nil
    var onCancelTapped: (() -> Void)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top) {
                Image(systemName: type.iconFileName)
                    .foregroundColor(type.themeColor)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 14, weight: .semibold))
                    
                    Text(message)
                        .font(.system(size: 12))
                        .foregroundColor(Color.black.opacity(0.6))
                }
                
                Spacer(minLength: 10)
                
                Button {
                    onCancelTapped()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                }
            }
            .padding()
            
            // Optional action view
            if let action = actionView {
                action
                    .padding(.horizontal)
                    .padding([.bottom], 12)
            }
        }
        .background()
        .overlay(
            Rectangle()
                .fill(type.themeColor)
                .frame(width: 6)
                .clipped()
            , alignment: .leading
        )
        .cornerRadius(8)
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
        .padding(.horizontal, 16)
    }
}

#Preview {
    ContentView()
}

//
//  DashboardCard.swift
//  DeviceInfo
//
//  Created by Nitin Bhatia on 15/11/25.
//

import SwiftUI

struct DashboardCard: View {
    let title: String
    let subtitle: String
    let desc: String?
    let icon: String
    let alignment: Alignment
    let imageColor: Color
    let imageContainerColor: Color
    
    init(
        title: String,
        subtitle: String,
        desc: String? = nil,
        icon: String,
        alignment: Alignment = .center,
        imageColor: Color = .blue,
        imageContainerColor: Color = .clear
    ) {
        self.title = title
        self.subtitle = subtitle
        self.desc = desc
        self.icon = icon
        self.alignment = alignment
        self.imageColor = imageColor
        self.imageContainerColor = imageContainerColor
    }
    
    
    var body: some View {
        VStack(alignment: alignment.horizontal, spacing: 8) {
            VStack {
                Image(systemName: icon)
                    .font(.system(size: 28))
                    .foregroundColor(imageColor)
                    .padding(5)
            }
            .background(imageContainerColor)
            .cornerRadius(8)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(subtitle)
                .font(.headline)
            
            if let desc = desc {
                
                Text(desc)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }

        .frame(maxWidth: .infinity, alignment: alignment)
        .cardStyle()
    }
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(20)
            .frame(maxWidth: .infinity, minHeight: 120)
            .background(.white)  // or .regularMaterial for more depth
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(Color(.systemGray3), lineWidth: 0.6)
            )
            .shadow(
                color: Color.black.opacity(0.08),
                radius: 12, x: 0, y: 4
            )
    }
}

struct CardView<Content: View>: View {
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        VStack {
            content()
        }
        
    }
}

#Preview {
    ContentView()
}

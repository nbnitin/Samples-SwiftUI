//
//  Header.swift
//  DynamicFloatSheetLikeFamilyApp
//
//  Created by Nitin Bhatia on 10/03/25.
//

import SwiftUI

func headerView(title: String, buttonAction: @escaping () -> Void, buttonImage: String = "xmark.circle.fill") -> some View {
    HStack {
        Text(title)
            .font(.title)
            .fontWeight(.semibold)
        Spacer(minLength: 0)
        Button(action: {
            withAnimation(.bouncy) {
                buttonAction()
            }
        }) {
            Image(systemName: buttonImage)
                .font(.title)
                .foregroundStyle(Color.gray, Color.primary.opacity(0.1))
        }
    }
    .padding(.bottom, 10)
}

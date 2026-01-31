//
//  EditView.swift
//  CustomPicker
//
//  Created by Nitin Bhatia on 26/01/26.
//

import SwiftUI
struct EditView: View {
    @Binding var editMode: Bool
    var body: some View {
        if editMode {
            Image(systemName: "checkmark")
                .font(.system(size: 25)).bold()
                .transition(.blurReplace.combined(with: .offset(x: -35)))
        } else {
            Image(systemName: "pencil")
                .resizable()
                .scaledToFill()
                .foregroundStyle(.primary)
                .frame(width: 20, height: 20)
                .transition(.blurReplace.combined(with: .offset(x: -35)))
        }
    }
}

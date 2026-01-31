//
//  EditModeModifier.swift
//  CustomPicker
//
//  Created by Nitin Bhatia on 26/01/26.
//

import SwiftUI

private struct DatePickerEditModifier: ViewModifier {
    @Binding var editMode: Bool

    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 20)
            .frame(height: editMode ? 105 : 60)
            .background(BG.teritary, in: UnevenRoundedRectangle(
                topLeadingRadius: editMode ? 12 : 0,
                bottomLeadingRadius: editMode ? 12 : 0,
                bottomTrailingRadius: 12,
                topTrailingRadius: 12
            ))
            .onTapGesture {
                withAnimation(!editMode ? .smooth(duration: 0.5, extraBounce: 0.5) : .smooth) {
                    editMode.toggle()
                }
            }
    }
}

extension View {
    func datePickerEditStyle(editMode: Binding<Bool>) -> some View {
        modifier(DatePickerEditModifier(editMode: editMode))
    }
}


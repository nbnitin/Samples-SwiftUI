//
//  SensoryFeedback.swift
//  UsefulModifiers
//
//  Created by Nitin Bhatia on 31/05/25.
//

//This enables  us to trigger haptics feedback with different  haptic levels. When the trigger value changes, the haptic feedback will be triggered eventually

//Note: Works on real device only

import SwiftUI

struct SensoryFeedback: View {
    @State private var isCompleted = false

        var body: some View {
            Button("Mark Complete") {
                isCompleted.toggle()
            }
            .sensoryFeedback(.impact, trigger: isCompleted)
        }
}

#Preview {
    SensoryFeedback()
}

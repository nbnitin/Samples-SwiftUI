//
//  ButtonRepeatBehaviour.swift
//  UsefulModifiers
//
//  Created by Nitin Bhatia on 31/05/25.
//

//Sometimes we  want to repeat the same action when a button is long pressed.

import SwiftUI

struct ButtonRepeatBehaviour: View {
    @State var count = 0
    @State var countDiabled = 0
    var body: some View {
        VStack(spacing: 9){
            Button("Add to Cart Enabled \(count)") {
                count += 1
            }
            .buttonRepeatBehavior(.enabled)
            
            Button("Add to Cart Disabled \(countDiabled)") {
                countDiabled += 1
            }
            .buttonRepeatBehavior(.disabled)
        }
    }
}

#Preview {
    ButtonRepeatBehaviour()
}

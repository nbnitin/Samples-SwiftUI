//
//  ContentView.swift
//  CustomPicker
//
//  Created by Nitin Bhatia on 24/01/26.
//

import SwiftUI

enum BG {
    static let teritary = Color.gray.opacity(0.2)
}

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            DatePickerCustom()
            ProductPickerCustom()
        }
    }
}

#Preview {
    ContentView()
}

//
//  PickerView.swift
//  Samples
//
//  Created by Nitin Bhatia on 01/05/25.
//

import SwiftUI

struct PickerView: View {
    @State private var selectedFruit = "Apple"
    @State private var showPicker = false

    let fruits = ["Apple", "Banana", "Orange", "Mango"]

    var body: some View {
        VStack {
            // Simulate a text field using a button or disabled TextField, Since textField has its own tap gesture and custom tap gesture won't apply so we need to do this like below
            Button(action: {
                showPicker = true
            }) {
                HStack() {
                    Text(selectedFruit)
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
//                    Spacer()
//                    Image(systemName: "chevron.down")
//                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5))
                )
            }
            .padding()

            Spacer()
        }
        .sheet(isPresented: $showPicker) {
            PickerSheetView(
                selectedFruit: $selectedFruit,
                showPicker: $showPicker,
                fruits: fruits
            )
        }
    }
}


struct PickerSheetView: View {
    @Binding var selectedFruit: String
    @Binding var showPicker: Bool
    let fruits: [String]

    var body: some View {
        VStack(spacing: 0) {
            // Toolbar or Done button
            HStack {
                Spacer()
                Button("Done") {
                    showPicker = false
                }
                .padding()
            }

            Divider()

            Picker("Select a fruit", selection: $selectedFruit) {
                ForEach(fruits, id: \.self) { fruit in
                    Text(fruit).tag(fruit)
                }
            }
            .pickerStyle(.wheel)
            .labelsHidden()
            .frame(maxWidth: .infinity)
        }
        .presentationDetents([.fraction(0.3)]) // iOS 16+, bottom sheet height
    }
}

#Preview {
    PickerView()
}

//
//  ProductPickerCustom.swift
//  CustomPicker
//
//  Created by Nitin Bhatia on 26/01/26.
//

import SwiftUI

struct ProductPickerCustom: View {
    @State private var editMode : Bool = false
    @State var product = "Select"
    
    private let products = ["Select","iPhone 16 Pro", "iPad Air", "MacBook Pro 14\"", "Apple Watch Series 10", "AirPods Pro", "HomePod mini", "Apple TV 4K"]
    
    var body: some View {
        HStack(spacing: editMode ? 20 : 0){
            CustPickerView(editMode: $editMode, title: "Select", selectedValue: $product, values: products, isLeft: true, fullWidth: true)
            
            ZStack {
                EditView(editMode: $editMode)
            }
            .datePickerEditStyle(editMode: $editMode)
        }
    }
}

#Preview {
    ContentView()
}


//
//  DatePickerCustom.swift
//  CustomPicker
//
//  Created by Nitin Bhatia on 26/01/26.
//

import SwiftUI

struct DatePickerCustom: View {
    @State private var editMode : Bool = false
    @State var hour = "20"
    @State var minute = "30"
    
    private let Hr = (0...24).map{String(format: "%01d", $0)}
    private let Min = (0...60).map{String($0)}
    
    var body: some View {
        HStack(spacing: editMode ? 20 : 0){
            CustPickerView(editMode: $editMode, title: "Hr", selectedValue: $hour, values: Hr, isLeft: true)
            CustPickerView(editMode: $editMode, title: "Min", selectedValue: $minute, values: Min, isLeft: false)
            
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


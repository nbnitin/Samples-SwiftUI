//
//  ContentView.swift
//  DropDown
//
//  Created by Nitin Bhatia on 28/11/23.
//

import SwiftUI

struct ContentView: View {
    //view properties
    @State private var selection: String?
    @State private var selection1: String?
    @State private var selection2: String?
    @State private var selectedValues: String?
    var body: some View {
        NavigationStack{
            VStack(spacing: 15) {
                DropDownView(hint: "Select", options: ["YouTube", "Instagram", "X (Twitter)", "Snapchat"], anchor: .top, selection: $selection)
                DropDownView(hint: "Select", options: ["YouTube", "Instagram", "X (Twitter)", "Snapchat"], anchor: .bottom, selection: $selection1)
                DropDownView(hint: "Select", options: ["Short Form", "Long Form", "Both"], anchor: .bottom, selection: $selection2)
                Button("Get Value") {
                    selectedValues = ($selection.wrappedValue ?? "") + "\n"
                    selectedValues! +=  ($selection1.wrappedValue ?? "") + "\n"
                    selectedValues! +=  ($selection2.wrappedValue ?? "")
                    print($selection.wrappedValue, $selection1.wrappedValue, $selection2.wrappedValue)
                }
                
                Label($selectedValues.wrappedValue ?? "", systemImage: "heart")
                .labelStyle(.titleOnly)
                
                
            }
            .navigationTitle("DropDown Picker")
        }
    }
}

#Preview {
    ContentView()
}

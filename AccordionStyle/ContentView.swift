//
//  ContentView.swift
//  Accordion
//
//  Created by Nitin Bhatia on 24/05/25.
//


import SwiftUI

struct ContentView: View {
    var sections : [SectionItem] = SectionItem.createDataSource()
    var body: some View {
        MultiDisclosureGroupView(sections: sections)
    }
}

#Preview {
    ContentView()
}

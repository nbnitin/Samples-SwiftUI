//
//  ContentView.swift
//  ChangeStatusBarStyle
//
//  Created by Nitin Bhatia on 27/11/23.
//

import SwiftUI

enum Style: String, CaseIterable {
    case defaults = "Defualt"
    case light = "Light"
    case dark = "Dark"
    
    var statusBarStyle: UIStatusBarStyle {
        switch self {
        case .defaults:
            return .default
        case .light:
            return .lightContent
        case .dark:
            return .darkContent
        }
    }
}

struct ContentView: View {
    
    @State private var statuBarStyle: Style = .defaults
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("", selection: $statuBarStyle) {
                    ForEach(Style.allCases, id: \.rawValue) {
                        Text($0.rawValue)
                            .tag($0)
                    }
                }
                .labelsHidden()
                .pickerStyle(.segmented)
                .onChange(of: statuBarStyle, initial: true) {oldValue, newValue in
                    UIApplication.shared.setStatusBarStyle(newValue.statusBarStyle)
                }
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}

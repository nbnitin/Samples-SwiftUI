//
//  ContentView.swift
//  DynamicFloatSheetLikeFamilyApp
//
//  Created by Nitin Bhatia on 08/03/25.
//

import SwiftUI

enum CurrentView {
    case actions
    case periods
    case keypad
}

struct ContentView: View {
    @State private var show: Bool = false
    @State private var currentView: CurrentView = .actions
    @State private var selectedPeriod: Period?
    @State private var duration: String = ""

    var body: some View {
        Button("Show") {
            selectedPeriod = nil
            duration = ""
            self.show.toggle()
        }
        .systemTrayView($show) {
            VStack(spacing: 20) {
                ZStack {
                    switch currentView {
                    case .actions: View1(headerAction: {
                        show = false
                    })
                    .transition(.blurReplace)
                    case .periods: View2(currentView: $currentView,selectedPeriod: $selectedPeriod,
                        headerAction: {
                        currentView = .actions
                    })
                            .transition(.blurReplace)
                    case .keypad:  View3(currentView: $currentView, duration: $duration)
                            .transition(.blurReplace)
                    }
                   
                }
                .compositingGroup()
                Button {
                    withAnimation(.bouncy)
                    {
                        if currentView == .periods && (!duration.isEmpty || selectedPeriod?.id != nil) {
                            show = false
                            return
                        }
                        currentView = .periods
                    }
                } label: {
                    Text("Continue")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .foregroundStyle(.white)
                        .background(.blue, in: .capsule)
                    
                    
                }
                .padding(.top, 15)
            }
            .padding(20)
        }
    }
}

#Preview {
    ContentView()
}

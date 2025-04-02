//
//  View2.swift
//  DynamicFloatSheetLikeFamilyApp
//
//  Created by Nitin Bhatia on 10/03/25.
//

import SwiftUI

import SwiftUI

struct View2: View {
    @Binding var currentView: CurrentView

    @Binding var selectedPeriod: Period?
    let headerAction: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            headerView(title: "Choose Periods") {
                headerAction()
            }
            
            Text("Choose the period you want\nto get subscribed.")
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.gray)
                .padding(.bottom, 20)
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 15) {
                ForEach(periods) { period in
                    let isSelected: Bool = selectedPeriod?.id == period.id
                    
                    VStack(spacing: 6) {
                        Text("\(period.title)")
                            .font(period.title == "0" ? .title3 : .title2)
                            .fontWeight(.semibold)
                        
                        if period.value != 0 {
                            Text(period.value == 1 ? "Month" : "Months")
                                .font(.caption)
                                .foregroundStyle(Color.gray)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(isSelected ? Color.blue.opacity(0.2) : Color.gray.opacity(0.1))
                    }
                    .contentShape(.rect)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            if period.value == 0 {
                                /// Navigate to custom keyboard
                                currentView = .keypad
                            } else {
                                selectedPeriod = isSelected ? nil : period
                            }
                        }
                    }
                }
            }
        }
    }
}

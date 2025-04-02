//
//  View1.swift
//  DynamicFloatSheetLikeFamilyApp
//
//  Created by Nitin Bhatia on 10/03/25.
//

import SwiftUI

struct View1: View {
    @State private var selectedAction: Action?
    
    let headerAction: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            headerView(title: "Choose Subscription") {
                headerAction()
            }
            
            ForEach(actions) { action in
                let isSelected: Bool = selectedAction?.id == action.id
                
                HStack(spacing: 10) {
                    Image(systemName: action.image)
                        .font(.title)
                        .frame(width: 40)
                    Text(action.title)
                        .fontWeight(.semibold)
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: isSelected ? "checkmark.circle.fill" : "circle.fill")
                        .font(.title)
                        .contentTransition(.symbolEffect)
                        .foregroundStyle(isSelected ? Color.blue : Color.gray.opacity(0.4))
                }
                .padding(.vertical, 6)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.snappy) {
                        selectedAction = action
                    }
                }
            }
        }
    }
}

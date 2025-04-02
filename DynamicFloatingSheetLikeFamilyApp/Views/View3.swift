//
//  View3.swift
//  DynamicFloatSheetLikeFamilyApp
//
//  Created by Nitin Bhatia on 10/03/25.
//


import SwiftUI

struct View3: View {
    @Binding var currentView: CurrentView
    @Binding var duration: String
    
    var body: some View {
        VStack(spacing: 12) {
            headerView(title: "Custom Duration") {
                currentView = .periods
            }
            
            VStack(spacing: 6) {
                Text(duration.isEmpty ? "0" : duration)
                    .font(.system(size: 60, weight: .bold))
                    .contentTransition(.numericText())
                
                Text("Days")
                    .font(.caption)
                    .foregroundStyle(Color.gray)
            }
            .padding(.vertical, 20)
            
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 15) {
                ForEach(keypadValue) { keyValue in
                    Group {
                        if keyValue.isBack {
                            Image(systemName: keyValue.title)
                                .foregroundStyle(duration.isEmpty ? Color.gray.opacity(0.5) : .primary)
                        } else {
                            Text(keyValue.title)
                        }
                    }
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .contentShape(.rect)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            if keyValue.isBack && !duration.isEmpty {
                                duration.removeLast()
                            } else {
                                duration.append(keyValue.title)
                            }
                        }
                    }
                    .disabled(keyValue.isBack && duration.isEmpty)
                }
            }
            .padding(.horizontal, -15)
        }
    }
}

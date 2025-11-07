//
//  ContentView.swift
//  AlertOpenZoomTransition
//
//  Created by Nitin Bhatia on 06/11/25.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var zoomTransitionNamespace
    @State private var showingModal = false
    
    var body: some View {
        Button("Open Modal") {
            showingModal = true
        }
        .matchedTransitionSource(id: "myZoomElement", in: zoomTransitionNamespace)
        .sheet(isPresented: $showingModal) {
            ModalView(namespace: zoomTransitionNamespace)
                .presentationDetents([.height(250)])
                .ignoresSafeArea()
        }
    }
}



struct ModalView: View {
    var namespace: Namespace.ID
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var currentColorScheme: ColorScheme
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .fill(.white.opacity(0.5))
            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment:.top, spacing: 8) {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.system(size: 26))
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Are you sure?")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)
                        
                        Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.")
                            .font(.subheadline)
                            .foregroundColor(currentColorScheme == .dark ? .white : .gray)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, 10)
                    }
                    
                }
                
                HStack(alignment: .bottom) {
                    Button(action: {}, label: {
                        Text("Cancel")
                    })
                    .foregroundStyle(Color.black)
                    .buttonStyle(.glassProminent)
                    .controlSize(.large)
                    .buttonSizing(.flexible)
                    .tint(.gray.opacity(0.7))
                    
                    
                    Button(action: {}, label: {
                        Text("Delete")
                    })
                    .buttonStyle(.glassProminent)
                    .controlSize(.large)
                    .buttonSizing(.flexible)
                    .tint(.red)
                }
                
            }
            .ignoresSafeArea()
            .padding(.horizontal, 20)
            .padding(.bottom, 30)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .navigationTransition(.zoom(sourceID: "myZoomElement", in: namespace)) // Apply zoom transition
        }
    }
}

#Preview {
    ContentView()
}

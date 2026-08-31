//
//  ContentView.swift
//  ReactionPickerParticleEffect
//
//  Created by Nitin Bhatia on 31/08/26.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedReaction: Character?
    @State private var showPopover: Bool = false
    @State private var addInsert: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 12) {
                    
                    Toggle("Force Popover", isOn: $showPopover)
                    
                    Toggle("Add Insert Button", isOn: $addInsert)
                }
                
                Spacer()
                
                ReactionPicker(
                    forcePopOver: $showPopover, addInsertButton: $addInsert,
                    reactions: ["👍", "❤️", "🔥", "🙂", "🎉"],
                    selectedReaction: $selectedReaction,
                    
                ) {
                    ZStack {
                        if let selectedReaction {
                            Text(String(selectedReaction))
                                .transition(.blurReplace)
                        } else {
                            Image(systemName: "face.smiling")
                                .transition(.blurReplace)
                        }
                    }
                    .font(.title3)
                    .foregroundStyle(Color.primary)
                    .frame(width: 45, height: 45)
                    .animation(.smooth, value: selectedReaction)
                    
                }
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Reaction Picker")
        }
    }
}

#Preview {
    ContentView()
}

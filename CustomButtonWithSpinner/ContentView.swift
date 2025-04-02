//
//  ContentView.swift
//  CustomButtonWithSpinner
//
//  Created by Nitin Bhatia on 27/03/25.
//

import SwiftUI

enum TranscationState: String {
    case idle = "Click to pay"
    case analysing = "Analysing Transaction"
    case processing = "Processing Transaction"
    case completed = "Transaction Completed"
    case failed = "Transaction Failed"
    
    var color: Color {
        switch self {
        case .idle:
            return .black
        case .analysing:
            return .blue
        case .processing:
            return Color(red: 0.8, green: 0.35, blue: 0.2)
        case .completed:
            return .green
        case .failed:
            return .red
        }
    }
    
    var image: String? {
        switch self {
        case .idle: "apple.logo"
        case .analysing: nil
        case .processing: nil
        case .completed: "checkmark.circle.fill"
        case .failed: "xmark.circle.fill"
        }
    }
    
}

struct ContentView: View {
    @State private var transactionState: TranscationState = .idle
    var body: some View {
        NavigationStack {
            VStack {
                let config = AnimatedButton.Config(title: transactionState.rawValue, foregroundColor: .white, backgroundColor: transactionState.color, symbolImage: transactionState.image)
                AnimatedButton(config: config, ontap: {
                    transactionState = .analysing
                    try? await Task.sleep(for: .seconds(3))
                    transactionState = .processing
                    try? await Task.sleep(for: .seconds(3))
                    transactionState = .completed
                    try? await Task.sleep(for: .seconds(3))
                    transactionState = .idle
                    
                })
            }
            .navigationTitle("Custom Button")
        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentView.swift
//  NetworkMonitor
//
//  Created by Nitin Bhatia on 19/04/25.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.isNetworkConnected) private var isConnected
    @Environment(\.connectionType) private var connectionType
    var body: some View {
        NavigationStack {
            List {
                Section("Status") {
                    Text((isConnected ?? false) ? "Connected" : "NotConnected")
                }
                
                if let connectionType {
                    Section("Connection Type") {
                        Text(String(describing: connectionType).uppercased())
                    }
                }
            }
            .navigationTitle(Text("Network Monitor"))
        }
        .sheet(isPresented: .constant(!(isConnected ?? false))) {
            NoInternetView()
                .presentationDetents([.height(310)])
                .presentationCornerRadius(0)
                .presentationBackgroundInteraction(.disabled)
                .presentationBackground(.clear)
                .interactiveDismissDisabled()
        }
        
    }
}

#Preview {
    ContentView()
}

struct NoInternetView: View {
    @Environment(\.isNetworkConnected) private var isConnected
    @Environment(\.connectionType) private var connectionType
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "wifi.exclamationmark")
                .font(.system( size: 80, weight: .semibold))
                .frame(height: 100)
            
            Text("No Internet Connection")
                .font(.title)
                .fontWeight(.semibold)
            
            Text("Please check your internet connection\nton continue")
                .multilineTextAlignment(.center)
                .foregroundStyle(.gray)
                .lineLimit(2)
            
            Text("Waiting for internet connection")
                .font(.caption)
                .foregroundStyle(.background)
                .padding(.vertical, 12)
                .frame(maxWidth: .infinity)
                .background(Color.primary)
                .padding(.top, -10)
                .padding(.horizontal, -20)
            
        }
        .fontDesign(.rounded)
        .padding([.horizontal, .top], 20)
        .background(.background)
        .clipShape(.rect(cornerRadius: 20))
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
        .frame(height: 310)
    }
}

//
//  ContentView.swift
//  DeviceInfo
//
//  Created by Nitin Bhatia on 14/11/25.
//

import SwiftUI

struct ContentView: View {
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    @State private var memoryPercentage: CGFloat = 0

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Text("System Dashboard")
                        .font(.largeTitle.bold())
                    VStack(alignment: .leading, spacing: 16) {
                        LazyVGrid(columns: [GridItem(.flexible())]) {
                            DashboardCard(title: "iPhone", subtitle: "iPhone", icon: "iphone.gen3", alignment: .center, imageColor: Color(red: 107/255, green: 172/255, blue: 229/255))
                                .frame(maxWidth: .infinity)
                        }
                        
                        // GRID SECTION
                        LazyVGrid(columns: columns, spacing: 20) {
                            
                            DashboardCard(title: "Battery", subtitle: "\(UIDevice.current.batteryLevel * 100)",
                                          desc: getBatteryStatus(),
                                          icon: batterySymbol(), alignment: .leading, imageColor: Color(red: 253/255, green: 245/255, blue: 234/255), imageContainerColor: Color(red: 223/255, green: 158/255, blue: 95/255))
                            
                            DashboardCard(title: "Time Zone", subtitle: TimeZone.current.identifier, desc: TimeZone.current.abbreviation(), icon: "globe"
                                          ,alignment: .leading, imageColor: Color(red: 112/255, green: 196/255, blue: 124/255), imageContainerColor: Color(red: 230/255, green: 245/255, blue: 234/255))
                            
                            DashboardCard(title: "Wi-Fi", subtitle: "Connected", icon: "wifi", alignment: .leading, imageColor: Color(red: 91/255, green: 148/255, blue: 199/255), imageContainerColor: Color(red: 229/255, green: 240/255, blue: 251/255))
                            
                            DashboardCard(title: "iOS Version", subtitle: UIDevice.current.systemVersion, icon: "apple.logo", alignment: .leading, imageColor: Color(red: 195/255, green: 71/255, blue: 223/255), imageContainerColor: Color(red: 247/255, green: 231/255, blue: 247/255))
                        }
                        
                    }
                    
                    
                    Text("Network Status")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "globe")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Connection Details")
                                .font(.title3)
                            
                        }
                        SettingsRow(title: "Status", value: "\(NetworkStatus().isConnected ? "Connected" : "Disconnected")")
                        SettingsRow(title: "WiFi", value: "\(NetworkStatus().connectionType)")
                        SettingsRow(title: "Type", value: "\(NetworkStatus().connectionType)")
                        
                        
                        
                    }
                    .frame(height: 200)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .cardStyle()
                    
                    Text("Storage")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "internaldrive")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        Text("Device Storage")
                            .font(.footnote)
                            .foregroundStyle(Color.gray)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(String(format: "Used Memory: %.1f%%", memoryPercentage))
                        ProgressView(value: memoryPercentage / 100)
                    }
                    .frame(height: 100)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .frame(maxHeight: .infinity, alignment: .top)
                    .cardStyle()
                    
                }
            }
            .scrollIndicators(.hidden)
            .padding(20)
            
        }
        .onAppear {
            startBatteryMonitoring()
            memoryPercentage = getFreeMemoryPercentage()
                        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { _ in
                            memoryPercentage = getFreeMemoryPercentage()
                        }
        }
    }
       
}


#Preview {
    ContentView()
}

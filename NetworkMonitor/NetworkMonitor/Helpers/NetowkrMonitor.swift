//
//  NetowkrMonitor.swift
//  NetworkMonitor
//
//  Created by Nitin Bhatia on 19/04/25.
//

import SwiftUI
import Network

extension EnvironmentValues {
    @Entry var isNetworkConnected: Bool?
    @Entry var connectionType: NWInterface.InterfaceType?
    
    
}

class NetworkMonitor: ObservableObject  {
    @Published var isConntected: Bool?
    @Published var connectionType: NWInterface.InterfaceType?
    
    private var queue = DispatchQueue(label: "NetworkMonitor")
    private var monitor = NWPathMonitor()
    
    init() {
        startMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            Task { @MainActor in
                self.isConntected = path.status == .satisfied
                
                let types: [NWInterface.InterfaceType] = [.cellular, .wifi, .wiredEthernet, .loopback]
                
                if let type = types.first(where: { path.usesInterfaceType($0) }) {
                    self.connectionType = type
                } else {
                    self.connectionType = nil
                }
            }
        }
        monitor.start(queue: queue)
    }
    
    private func stopMonitoring() {
        
    }
    
}

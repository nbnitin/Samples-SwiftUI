//
//  UtilsAndExtensions.swift
//  DeviceInfo
//
//  Created by Nitin Bhatia on 15/11/25.
//
import SwiftUI
import Network
import Foundation
import MachO
import Combine

let startBatteryMonitoring = {
    UIDevice.current.isBatteryMonitoringEnabled = true
}


func batterySymbol() -> String {
    let level = UIDevice.current.batteryLevel * 100
    switch level {
    case 0: return "battery.0"
    case 1...25: return "battery.25"
    case 26...50: return "battery.50"
    case 51...75: return "battery.75"
    default: return "battery.100"
    }
}

func getBatteryStatus() -> String? {
    switch UIDevice.current.batteryState {
    case .charging:
        return "Charging"
    case .full:
        return "Full"
    case .unplugged:
        return "Not charging"
    case .unknown:
        return "Unknown"
    default: return nil
    }
}

class NetworkStatus: ObservableObject {
    @Published var isConnected: Bool = false
    @Published var connectionType: String = "Unknown"   // Wi-Fi / Cellular / Offline
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "NetworkMonitor")
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
                
                if path.usesInterfaceType(.wifi) {
                    self?.connectionType = "Wi-Fi"
                } else if path.usesInterfaceType(.cellular) {
                    self?.connectionType = "Cellular"
                } else {
                    self?.connectionType = "Offline"
                }
            }
        }
        
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
}



func getUsedMemory() -> UInt64 {
    var info = mach_task_basic_info()
    var count = mach_msg_type_number_t(MemoryLayout<mach_task_basic_info>.size) / 4

    let kerr = withUnsafeMutablePointer(to: &info) {
        $0.withMemoryRebound(to: integer_t.self, capacity: 1) {
            task_info(mach_task_self_, task_flavor_t(MACH_TASK_BASIC_INFO), $0, &count)
        }
    }

    return kerr == KERN_SUCCESS ? UInt64(info.resident_size) : 0
}

func getTotalMemory() -> UInt64 {
    return ProcessInfo.processInfo.physicalMemory
}

func getUsedMemoryPercentage() -> CGFloat {
    let used = Double(getUsedMemory())
    let total = Double(getTotalMemory())
    return CGFloat((used / total) * 100)
}

func getFreeMemoryPercentage() -> CGFloat {
    let used = Double(getUsedMemory())
    let total = Double(getTotalMemory())
    return CGFloat(((total - used) / total) * 100)
}

extension View {
    func cardStyle() -> some View {
        self.modifier(CardModifier())
    }
}

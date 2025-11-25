//
//  SettingsRow.swift
//  DeviceInfo
//
//  Created by Nitin Bhatia on 15/11/25.
//

import SwiftUI

struct SettingsRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .font(.subheadline)
                .foregroundColor(.primary)
        }
        .padding(.vertical, 8)
        
        Divider() // thin separator like iOS Settings
            .padding(.leading)
    }
}

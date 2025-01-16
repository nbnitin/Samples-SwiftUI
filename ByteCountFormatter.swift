//
//  ContentView.swift
//  Samples
//
//  Created by Nitin Bhatia on 22/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Image(systemName: "arrow.down.circle.fill")
                .foregroundStyle(Color.green)
                .font(.system(size: 200))
            Text(ByteCountFormatter.string(fromByteCount: 1_000_000, countStyle: .file))
                .font((.system(size: 90)))
        }
    }
}

#Preview {
    ContentView()
}

//
//  ContentMargins.swift
//  UsefulModifiers
//
//  Created by Nitin Bhatia on 31/05/25.
//

//this enable us to customize the margins for both scroll content and the scroll indicator without resorting to padding or safeArea modifier

import SwiftUI

struct ContentMargins: View {
    var body: some View {
        ScrollView(.vertical) {
            Rectangle()
                .fill(.yellow)
                .containerRelativeFrame(.vertical) {value, _ in
                    value * 5
                    
                }
        }
        .contentMargins(.vertical, 50, for: .scrollIndicators)
        .contentMargins(.trailing, 20, for: .scrollIndicators)
    }
}

#Preview {
    ContentMargins()
}

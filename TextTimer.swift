import SwiftUI

struct ContentView: View {
    var body: some View {
        Text(timerInterval: .now...Date(timeIntervalSinceNow: 90), countsDown: false)
            .font(.system(size: 60, weight: .heavy))
            .italic()
        
        Text(timerInterval: .now...Date(timeIntervalSinceNow: 90), countsDown: true)
            .font(.system(size: 60, weight: .heavy))
            .italic()
    }
}

#Preview {
    ContentView()
}

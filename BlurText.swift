import SwiftUI

let FONT_SIZE : CGFloat = 50

struct ContentView: View {
    var body: some View {
        HStack{
            Text("This Is")
            Text("Blur")
                .blur(radius: (FONT_SIZE * 10) / 100)
            Text("Text")
        }
        .font(.system(size: FONT_SIZE, weight: .bold))
    }
}

#Preview {
    ContentView()
}

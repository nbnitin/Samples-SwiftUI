import SwiftUI



struct ContentView: View {
    @State var scale: CGFloat = 1.0
    @State var count : Int = 0
    var body: some View {
        Circle()
            .fill(Color.blue)
            .frame(width: 200)
            .contentShape(.rect)
            .background(Color.yellow)
            .onTapGesture {
                print("Tapped number \(count)")
                count = count + 1
            }
    }
}



#Preview {
    ContentView()
}

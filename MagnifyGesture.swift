import SwiftUI


struct ContentView: View {
    @State var scale: CGFloat = 1.0
    var body: some View {
        VStack{
            Image("img")
                .resizable()
                .scaledToFit()
                .scaleEffect(scale)
                .gesture(
                    MagnifyGesture()
                        .onChanged{
                            scale = $0.magnification
                        }
                )
               
        }
    }
}

#Preview {
    ContentView()
}

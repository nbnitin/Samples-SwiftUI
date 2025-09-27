import SwiftUI

struct ContentView: View {
    @State private var path = NavigationPath()
    @Namespace private var namespace

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Image("img1")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    // MARK: This is the zoom source
                    .navigationTransition(.zoom(sourceID: "zoomImage", in: namespace))
                    .onTapGesture {
                        path.append("fullImage")
                    }
            }
            .navigationTitle("Zoom Transition")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: String.self) { value in
                if value == "fullImage" {
                    FullImageView()
                        // MARK: This is the zoom destination
                        .navigationTransition(.zoom(sourceID: "zoomImage", in: namespace))
                }
            }
        }
    }
}

import SwiftUI

struct FullImageView: View {
    var body: some View {
        Image("img1")
            .resizable()
            .frame(maxWidth: .infinity,
                       maxHeight: .infinity)
            .scaledToFill()
            .ignoresSafeArea(.all)
    }
}

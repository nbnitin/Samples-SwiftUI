import SwiftUI
import PhotosUI
import CoreGraphics

struct ContentView: View {
    @State private var avatarItem: PhotosPickerItem?
    @State private var avatarImage: UIImage?
    
    var dominantColor: Color {
        if let avatarImage = avatarImage {
            return Color(uiColor: avatarImage.dominantColor() ?? .gray)
        }
        return .gray
    }

    var body: some View {
        VStack {
            PhotosPicker("Select Avatar", selection: $avatarItem, matching: .images)
            
            if let uiImage = avatarImage {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                    .background(dominantColor)
            }
        }
        .onChange(of: avatarItem) { _, newItem in
            Task {
                if let newItem = newItem,
                   let data = try? await newItem.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    avatarImage = uiImage
                } else {
                    print("Failed to load image")
                }
            }
        }
    }
}

// MARK: - UIImage Extension for Advanced Dominant Color Extraction
extension UIImage {
    func dominantColor() -> UIColor? {
        guard let cgImage = self.cgImage else { return nil }

        let width = 50, height = 50  // Increase sample resolution
        guard let resizedCGImage = cgImage.resizeImage(newWidth: width, newHeight: height) else { return nil }

        guard let pixelData = resizedCGImage.dataProvider?.data,
              let data = CFDataGetBytePtr(pixelData) else { return nil }

        var colorCounts = [UInt32: Int]()

        for x in 0..<width {
            for y in 0..<height {
                let pixelIndex = ((y * width) + x) * 4
                let r = data[pixelIndex]
                let g = data[pixelIndex + 1]
                let b = data[pixelIndex + 2]

                let color = UInt32(r) << 16 | UInt32(g) << 8 | UInt32(b)
                colorCounts[color, default: 0] += 1
            }
        }

        // Filter out grayscale colors (low saturation)
        let filteredColors = colorCounts.filter { color, _ in
            let r = CGFloat((color >> 16) & 0xFF) / 255.0
            let g = CGFloat((color >> 8) & 0xFF) / 255.0
            let b = CGFloat(color & 0xFF) / 255.0
            let maxComponent = max(r, g, b)
            let minComponent = min(r, g, b)
            return (maxComponent - minComponent) > 0.1  // Exclude grayscale colors
        }

        // Find the most common color from filtered list
        guard let mostFrequentColor = filteredColors.max(by: { $0.value < $1.value })?.key else {
            return nil
        }

        return UIColor(
            red: CGFloat((mostFrequentColor >> 16) & 0xFF) / 255.0,
            green: CGFloat((mostFrequentColor >> 8) & 0xFF) / 255.0,
            blue: CGFloat(mostFrequentColor & 0xFF) / 255.0,
            alpha: 1.0
        )
    }
}

// MARK: - CGImage Extension for Resizing
extension CGImage {
    func resizeImage(newWidth: Int, newHeight: Int) -> CGImage? {
        let context = CGContext(
            data: nil,
            width: newWidth,
            height: newHeight,
            bitsPerComponent: self.bitsPerComponent,
            bytesPerRow: newWidth * 4,
            space: self.colorSpace ?? CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: self.bitmapInfo.rawValue
        )

        context?.draw(self, in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        return context?.makeImage()
    }
}

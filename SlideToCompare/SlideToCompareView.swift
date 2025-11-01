import SwiftUI

enum InitialPosition {
    case full      // rhs covers full screen
    case half      // rhs covers half of the screen
    case percentage(Double)
}

private var indicatorImage: Image = Image(systemName: "arrow.left.and.right")
private var indicatorImageWidth: CGFloat = 22
private var indicatorImageColor: Color = .gray
private var indicatorColor: Color = .white
private var indicatorWidth: CGFloat = 44
private var dividerColor: Color = .clear
private var dividerWidth: CGFloat = .zero

struct SliderComparisionView<UpperView: View, LowerView: View>: View {
    @State private var dividerLocation: CGFloat? = nil
    private let lhs: () -> UpperView
    private let rhs: () -> LowerView
    private let initialPosition: InitialPosition
    
    public init(
        initialPosition: InitialPosition = .half,
        @ViewBuilder lhs: @escaping () -> UpperView,
        @ViewBuilder rhs: @escaping () -> LowerView
    ) {
        self.initialPosition = initialPosition
        self.lhs = lhs
        self.rhs = rhs
    }
    
    public var body: some View {
        GeometryReader { geo in
            ZStack {
                lhs()
                
                rhs()
                    .mask {
                        Rectangle()
                            .offset(x: (dividerLocation ?? initialOffset(for: geo.size.width)) + geo.size.width / 2)
                    }
                
                dividerView()
                    .offset(x: dividerLocation ?? initialOffset(for: geo.size.width))
            }
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        dividerLocation = min(
                            max(gesture.location.x - geo.size.width / 2, -geo.size.width / 2),
                            geo.size.width / 2
                        )
                    }
            )
            // ✅ Use helper instead of hardcoded left edge
            .onAppear {
                withAnimation(.easeOut(duration: 0.6)) {
                    dividerLocation = initialOffset(for: geo.size.width)
                }
            }
            // ✅ Update on rotation correctly
            .onChange(of: geo.size.width) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    dividerLocation = initialOffset(for: geo.size.width)
                }
            }
        }
        .ignoresSafeArea()
    }
    
    // MARK: - Helper
    private func initialOffset(for width: CGFloat) -> CGFloat {
        switch initialPosition {
        case .full:
            return -width / 2  // divider on right edge (rhs fully visible)
        case .half:
            return 0           // divider centered (half-half)
        case .percentage(let percent):
            let clamped = max(0, min(100, percent))
            // -width/2 = fully right; +width/2 = fully left
            // So convert percentage to offset (0% → full RHS visible)
            return (width * (50 - clamped) / 100)
            
        }
    }
}

private func dividerView() -> some View {
    Rectangle()
        .fill(dividerColor)
        .frame(width: dividerWidth)
        .overlay {
            Circle()
                .fill(indicatorColor)
                .frame(width: indicatorWidth)
                .overlay {
                    indicatorImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: indicatorImageWidth)
                        .foregroundColor(indicatorImageColor)
                }
        }
}

#Preview("Half Example") {
    // Try switching between .full and .half to test
    SliderComparisionView(initialPosition: .half) {
        Image("alex-mustaros-KiXSWo3cEAI-unsplash")
            .resizable()
    } rhs: {
        Image("ansgar-scheffold-fx-7PHfhd6w-unsplash")
            .resizable()
    }
}

#Preview("Full Example") {
    // Try switching between .full and .half to test
    SliderComparisionView(initialPosition: .full) {
        Color.blue
    } rhs: {
        Color.red
    }
}

#Preview("Percentage Example") {
    // Try switching between .full and .half to test
    SliderComparisionView(initialPosition: .percentage(40)) {
        Color.blue
    } rhs: {
        Color.red
    }
}

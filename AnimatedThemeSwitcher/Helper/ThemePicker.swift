//
//  ThemePicker.swift
//  AnimatedThemeSwitcher
//
//  Created by Nitin Bhatia on 13/10/26.
//

import SwiftUI

enum Theme: String, CaseIterable {
    case light = "Light"
    case dark = "Dark"
    case system = "System"
    
    var symbol: String {
        switch self {
        case .light: return "sun.max.fill"
        case .dark: return "moon.fill"
        case .system: return "circle.lefthalf.filled"
        }
    }
    var captionText: String {
        switch self {
        case .light: return "Light appearance stays on, day and night."
        case .dark: return "Dark appearance stays on, day and night."
        case .system: return "Matches your iPhone settings, day and night"
        }
    }
}

extension View {
    @ContentBuilder
    func themePicker(isPresented: Binding<Bool>, value: Binding<Theme>, envColorScheme: ColorScheme)-> some View {
        self
            .sheet(isPresented: isPresented){
                ThemePicker (value: value, colorScheme: envColorScheme)
                    .environment (\.colorScheme, envColorScheme)
                    .presentationCompactAdaptation(.sheet)
                    .presentationDetents([.height (300)])
            }
    }
}

struct ThemePicker: View {
    var colorScheme: ColorScheme
    @Binding var value: Theme
    init (value: Binding<Theme>, colorScheme: ColorScheme) {
        self._value = value
        self.colorScheme = colorScheme
        isDark = colorScheme == .dark
    }
    /// View Properties
    @State private var isDark: Bool
    @Namespace private var animation
    var body: some View {
        VStack(spacing: 15) {
            AnimatedPreview()
                .frame(height: 200)
            
            SegmentControl()
            
            Text(value.captionText)
                .font(.caption)
                .foregroundStyle(isDark ? .white : .secondary)
                .lineLimit(1)
                .animation(.smooth(duration: 0.45, extraBounce: 0), value: value)
        }
        .padding(.horizontal, 15)
        .padding(.top, 15)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .presentationBackground(isDark ? .black.mix(with: .white, by: 0.2) : .white)
        .onChange(of: colorScheme) { oldValue, newValue in
            let isDark = newValue == .dark
            DispatchQueue.main.async {
                withAnimation(.interpolatingSpring(duration: 1, bounce: 0, initialVelocity: 0)) {
                    self.isDark = isDark
                }
            }
            
        }
        
//        .onTapGesture {
//            withAnimation(.interpolatingSpring(duration: 1, bounce: 0, initialVelocity: 0)) {
//                isDark.toggle()
//            }
//        }
    }
    
    
    @ContentBuilder
    private func AnimatedPreview() -> some View {
        GeometryReader{
            let size = $0.size
            let gradientColors = isDark ? [Color.darkTop, Color.darkBottom] : [Color.lightTop, Color.ligthBottom]
            ZStack{
                LinearGradient(colors: gradientColors, startPoint: .top, endPoint: .bottom)
                    .clipShape(ConcentricRectangle(corners: .concentric, isUniform: true))
                
                /// stars for light mode only
                StarsView(count: 20)
                    .opacity(isDark ? 1 : 0)
                
                /// Moon and Sun animated view
                ZStack{
                    
                    Image (systemName: "moon.fill")
                        .font(.system(size: 50))
                        .foregroundStyle(Color.moon)
                        .shadow(color: Color.moon.opacity(0.6), radius: 15)
                        .rotationEffect(.init(degrees: isDark ? -130 : 0))
                        .frame(width: size.width, height: size.width)
                        .offset(x: -(size.width - 40) / 2)
                        .rotationEffect(.init(degrees: isDark ? 130 : -30))
                        .offset (y: 10)
                    
                    Image(systemName: "sun.max.fill")
                        .font(.system(size: 85, weight: .ultraLight))
                        .foregroundStyle(.yellow)
                        .shadow(color: .white, radius: 15)
                    //adding keyframe
                        .compositingGroup()
                        .keyframeAnimator(initialValue: CGFloat.zero, repeating: true) { content, rotation in content
                                .rotationEffect (.degrees (rotation))
                        } keyframes: { _ in
                            LinearKeyframe(360, duration: 60)
                        }
                    
                    //Circling Back & torth between dark/light mode states
                        .frame(width: size.width, height: size.width)
                        .offset(x: -(size.width - 40) / 2)
                        .rotationEffect(.init(degrees: isDark ? 200 : 130))
                        .offset (y: 10)
                }
                .frame(width: size.width, height: size.height, alignment: .top)
                
                
                ///Shooting Star for Dark Mode
                if isDark {
                    KeyframeAnimator (initialValue: CGFloat.zero, repeating: true) { offset in
                        let opacity = max(min(offset / 200, 1), 0)
                        Capsule()
                            .fill(LinearGradient (colors: [
                                Color.moon,
                                Color.moon.opacity(0.5),
                                Color.moon.opacity(0.3),
                                Color.moon.opacity (0.3),
                                . clear
                            ], startPoint: .trailing, endPoint: .leading))
                            .frame (width: 100, height: 2)
                            .offset(x: offset, y: 25)
                            .rotationEffect(.init(degrees: 25))
                            .opacity (1 - opacity)
                            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    } keyframes: { _ in
                        MoveKeyframe (-100)
                        LinearKeyframe(-100, duration: 1.5)
                        CubicKeyframe (200, duration: 1.8)
                        LinearKeyframe(200, duration: 3)
                    }
                }
                
                //clouds
                HStack(spacing: 0) {
                    Image(systemName: "cloud.fill")
                        .font(.system(size: 50))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.1) ,radius: 5)
                        .offset(x: isDark ? -100 : 0, y: -30)
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: "cloud.fill")
                        .font(.system(size: 55))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.1) ,radius: 5)
                        .offset(x: isDark ? 100 : 0, y: 0)
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: "cloud.fill")
                        .font(.system(size: 40))
                        .foregroundStyle(.white)
                        .shadow(color: .black.opacity(0.1) ,radius: 5)
                        .offset(x: isDark ? 100 : 0, y: 35)
                }
                .padding(.horizontal, 20)
                .compositingGroup()
                .blur(radius: isDark ? 30: 0)
                .opacity(isDark ? 0 : 1)
                
                /// Grouped Layers
                ZStack {
                    GroundShape(density: 0.5)
                        .fill(isDark ? Color.hillTopDark : Color.hillTopLight)
                    
                    GroundShape(density: 0.35)
                        .fill(isDark ? Color.hillCenterDark : Color.hillCenterLight)
                    
                    GroundShape(density: 0.2)
                        .fill(isDark ? Color.hillBottomDark : Color.hillBottomLight)
                    
                    
                    //house symbol for dark mode only with light
                    
                    Image(systemName: "house.lodge.fill")
                        .font(.system(size: 20))
                        .foregroundStyle(.black.mix(with: .white, by: isDark ? 0.1 : 0.4))
                    //house light
                        .background(alignment: .bottom){
                            Circle()
                                .fill(.yellow.opacity(isDark ? 1 : 0))
                                .frame(width: 12, height: 12)
                                .shadow(color: .yellow.opacity(isDark ? 1 : 0), radius: 5)
                        }
                    
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
                        .offset(x: 50, y: -120 * 0.37)
                    
                }
                .frame(height: 100)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
            
            
        }
        .clipShape(ConcentricRectangle(corners: .concentric, isUniform: true))
    }
    
    //Custom Segment control
    @ContentBuilder
    private func SegmentControl()-> some View {
        HStack(spacing: 0) {
            ForEach(Theme.allCases, id: \.rawValue) {theme in
                let isSelected = value == theme
                let tintColor:Color = isDark ? .indigo : .yellow.mix(with: .orange, by: 0.2)
                HStack(spacing: 8) {
                    Image(systemName: theme.symbol)
                        .font(.system(size: 16))
                        .foregroundStyle(isSelected ? tintColor : .primary)
                        .environment(\.colorScheme, .dark)
                    Text(theme.rawValue)
                        .font(.callout)
                }
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background {
                    if isSelected {
                        ZStack {
                            Capsule()
                                .fill(isDark ? .black : .white)
                            
                            Capsule()
                                .stroke(tintColor, lineWidth: 1.5)
                        }
                        .compositingGroup()
                        .shadow(color: tintColor.opacity(0.3), radius: 10)
                        .matchedGeometryEffect(id: "CAPSULRE", in: animation)
                    }
                }
                .onTapGesture {
                    value = theme
                    
                }
            }
        }
        .frame(height: 40)
        .padding(4)
        .background(.gray.opacity(0.15), in: .capsule)
        .animation(.bouncy(duration: 0.5, extraBounce: 0.1), value: value)
    }
}

fileprivate struct StarsView: View {
    var count: Int
    var body: some View {
        Canvas { context, size in
            for i in 0 ..< count {
                let x = random(i, 1) * size.width
                let y = random(i, 2) * size.height
                let size = random(i, 3) > 0.66 ? 3.0 : 2.0
                let opacity = 0.5 + random (i, 4) * 0.5
                let star = Path(ellipseIn: CGRect(x: x, y: y, width: size, height: size))
                context.fill(star, with: .color(.white.opacity(opacity)))
            }
        }
        . allowsHitTesting(false)
    }
    
    private func random(_ i: Int,_ seed: Double) -> Double {
        let value = sin(Double(i) * 22.5 + seed * 99.2) * 43.6
        return value - value.rounded (.down)
    }
    
}



fileprivate struct GroundShape: Shape {
    var density: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let width = rect.width
        
        let height = rect.height
        
        let base = height * (1 - density)
        
        let wave = height * density * 0.55
        return Path { path in
            path.move(to: CGPoint (x: 0, y: base))
            path.addCurve(
                to: CGPoint(x: width * 0.5, y: base + wave * 0.3), control1: CGPoint(x: width * 0.18, y: base - wave), control2: CGPoint(x: width * 0.35, y: base - wave * 0.8))
            path.addCurve(
                to: CGPoint (x: width, y: base - wave * 0.4), control1: CGPoint (x: width * 0.65, y: base + wave * 1.4), control2: CGPoint (x: width * 0.85, y: base - wave))
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint (x: 0, y: height))
            path.closeSubpath()
        }
    }
}



#Preview {
    ContentView()
}

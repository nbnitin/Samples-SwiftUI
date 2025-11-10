//
//  ContentView.swift
//  ColorAnimation
//
//  Created by Nitin Bhatia on 07/11/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    HeaderView()
                    HueRotateGradient()
                        .frame(height: 180)
                        .cornerRadius(16)
                        .padding(.horizontal)
                    SweepGradientCard()
                        .frame(height: 180)
                        .cornerRadius(16)
                        .padding(.horizontal)
                    PulsingBlobCard()
                        .frame(height: 220)
                        .cornerRadius(16)
                        .padding(.horizontal)
                    ColorCycleCircle()
                        .frame(height: 180)
                        .cornerRadius(16)
                        .padding(.horizontal)
                    RainbowTextCard()
                        .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .navigationTitle("Color Show-Off")
        }
    }
}

struct HeaderView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Fancy Color Animations")
                    .font(.title2).bold()
                Text("SwiftUI demos — tweak durations & palettes to suit your vibe.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

// MARK: 1) Hue-rotating animated gradient
struct HueRotateGradient: View {
    @State private var animate = false
    var body: some View {
        ZStack {
            // A diagonal linear gradient that continuously shifts hue
            LinearGradient(
                gradient: Gradient(colors: [.pink, .purple, .blue, .green, .yellow]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .hueRotation(.degrees(animate ? 360 : 0)) // smooth hue shift
            .animation(.linear(duration: 8).repeatForever(autoreverses: false), value: animate)
            VStack {
                Text("Hue Rotation")
                    .font(.headline)
                    .foregroundColor(.white)
                    .shadow(radius: 6)
                Text("subtle, infinite color sweep")
                    .font(.caption2)
                    .foregroundColor(.white.opacity(0.9))
            }
        }
        .onAppear { animate = true }
    }
}

// MARK: 2) Sweep / Angular gradient with moving center & blur
struct SweepGradientCard: View {
    @State private var angle: Double = 0
    @State private var center: UnitPoint = .center

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Sweep gradient that rotates and drifts
                AngularGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.9, green: 0.2, blue: 0.6),
                        Color(red: 0.2, green: 0.4, blue: 1.0),
                        Color(red: 0.0, green: 0.9, blue: 0.5),
                        Color(red: 1.0, green: 0.8, blue: 0.1)
                    ]),
                    center: center,
                    startAngle: .degrees(angle),
                    endAngle: .degrees(angle + 360)
                )
                .blendMode(.screen)
                .blur(radius: 12)
                .animation(.easeInOut(duration: 6).repeatForever(autoreverses: true), value: center)
                .animation(.linear(duration: 12).repeatForever(autoreverses: false), value: angle)

                RoundedRectangle(cornerRadius: 12)
                    .fill(.ultraThinMaterial) // nice frosted overlay
                    .overlay(
                        VStack {
                            Text("Sweep Gradient")
                                .font(.headline)
                            Text("rotating + drifting center")
                                .font(.caption2)
                        }
                        .padding()
                    )
                    .padding(18)
            }
            .onAppear {
                // animate rotation and drifting center
                withAnimation { angle = 360 }
                // move center around
                Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { _ in
                    withAnimation(.easeInOut(duration: 3)) {
                        center = UnitPoint(x: .random(in: 0.2...0.8), y: .random(in: 0.2...0.8))
                    }
                }
            }
        }
    }
}

// MARK: 3) Pulsing colorful blob with glow
struct PulsingBlobCard: View {
    @State private var scale: CGFloat = 1.0
    @State private var hue: Double = 0.0

    var body: some View {
        ZStack {
            // background
            Color.black.opacity(0.06)
            ZStack {
                // layered blurred blobs for depth
                BlobView(scale: scale)
                    .hueRotation(.degrees(hue))
                    .blendMode(.plusLighter)
                    .opacity(0.9)
                BlobView(scale: scale * 0.7)
                    .hueRotation(.degrees(hue + 90))
                    .blendMode(.screen)
                    .opacity(0.8)
                BlobView(scale: scale * 0.5)
                    .hueRotation(.degrees(hue + 180))
                    .blendMode(.screen)
                    .opacity(0.7)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            VStack {
                Spacer()
                Text("Pulsing Blob")
                    .font(.headline).foregroundColor(.primary)
                Text("soft glow, color morph")
                    .font(.caption2).foregroundColor(.secondary)
                Spacer().frame(height: 12)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
                scale = 1.18
            }
            withAnimation(.linear(duration: 10).repeatForever(autoreverses: false)) {
                hue = 360
            }
        }
    }
}

struct BlobView: View {
    var scale: CGFloat

    var body: some View {
        GeometryReader { g in
            let s = min(g.size.width, g.size.height)
            ZStack {
                Circle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.pink.opacity(0.9), Color.orange.opacity(0.9)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(width: s * 0.8 * scale, height: s * 0.8 * scale)
                    .offset(x: -s * 0.1, y: -s * 0.05)
                    .blur(radius: 30)
                Circle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.blue.opacity(0.9), Color.purple.opacity(0.9)]),
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading
                    ))
                    .frame(width: s * 0.6 * scale, height: s * 0.6 * scale)
                    .offset(x: s * 0.15, y: s * 0.05)
                    .blur(radius: 36)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

// MARK: 4) Color cycling ring (TimelineView for smooth time-based animation)
struct ColorCycleCircle: View {
    var body: some View {
        TimelineView(.animation) { timeline in
            let now = timeline.date.timeIntervalSinceReferenceDate
            // create a hue shift based on time
            let hue = now.truncatingRemainder(dividingBy: 6) / 6.0
            ZStack {
                Circle()
                    .strokeBorder(lineWidth: 26)
                    .opacity(0.25)
                    .foregroundStyle(.secondary)
                Circle()
                    .trim(from: 0, to: 0.85)
                    .stroke(style: StrokeStyle(lineWidth: 26, lineCap: .round))
                    .foregroundStyle(
                        AngularGradient(
                            gradient: Gradient(colors: [
                                Color(hue: hue, saturation: 0.9, brightness: 0.9),
                                Color(hue: hue + 0.15, saturation: 0.9, brightness: 0.9),
                                Color(hue: hue + 0.33, saturation: 0.9, brightness: 0.9),
                                Color(hue: hue + 0.5, saturation: 0.9, brightness: 0.9)
                            ]),
                            center: .center
                        )
                    )
                    .rotationEffect(.degrees(now.truncatingRemainder(dividingBy: 360) * 30))
                VStack {
                    Text("Color Cycle")
                        .font(.headline)
                    Text("time-driven hue shift")
                        .font(.caption2).foregroundColor(.secondary)
                }
            }
            .padding(28)
        }
    }
}

// MARK: 5) Rainbow animated text using mask + moving gradient
struct RainbowTextCard: View {
    @State private var offset: CGFloat = -1.0

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(UIColor.systemBackground))
                .shadow(radius: 6)
            VStack(spacing: 12) {
                ZStack {
                    Text("Show-Off Text")
                        .font(.system(size: 42, weight: .heavy, design: .rounded))
                        .foregroundStyle(.primary)
                        .overlay(
                            // moving gradient mask
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    .red, .orange, .yellow, .green, .blue, .purple, .pink
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .scaleEffect(x: 3, y: 1, anchor: .center)
                            .offset(x: offset * 300)
                            .mask(
                                Text("Show-Off Text")
                                    .font(.system(size: 42, weight: .heavy, design: .rounded))
                            )
                        )
                }
                .onAppear {
                    // slide the gradient across the text forever
                    withAnimation(.linear(duration: 3.6).repeatForever(autoreverses: false)) {
                        offset = 1.0
                    }
                }

                Text("animated gradient mask")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
        .padding(.vertical)
    }
}

// Simple preview for Xcode canvas
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}

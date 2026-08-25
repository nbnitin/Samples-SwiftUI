//
//  ContentView.swift
//  CelebrationAnimation
//
//  Created by Nitin Bhatia on 21/08/26.
//

import SwiftUI

// MARK: - 1. Particle Data Model
struct FloatingParticle: Identifiable {
    let id = UUID()
    let emoji: String
    var xOffset: CGFloat       // Horizontal position on screen
    var yOffset: CGFloat       // Vertical position (starts below screen)
    var scale: CGFloat         // Random size variation
    var speed: CGFloat         // How fast it floats up
    var opacity: Double = 1.0  // Fades out near the top
}

// MARK: - 2. Particle Emitter Engine
struct CelebrationEmitterView: View {
    @Binding var isTriggered: Bool
    @State private var particles: [FloatingParticle] = []
    
    // Customize your asset pool here (cookies, confetti, stars)
    let emojiPool = ["🍪", "✨", "🎉", "🍪", "🔥", "🥳", "🍩", "💖"]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Render the active items on screen
                ForEach(particles) { particle in
                    Text(particle.emoji)
                        .font(.system(size: 40))
                        .scaleEffect(particle.scale)
                        .position(x: particle.xOffset, y: particle.yOffset)
                        .opacity(particle.opacity)
                        .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
                }
            }
            .onAppear {
                if isTriggered { generateParticles(in: geometry.size) }
            }
            .onChange(of: isTriggered) { newValue in
                if newValue {
                    generateParticles(in: geometry.size)
                } else {
                    particles.removeAll()
                }
            }
            .task(id: isTriggered) {
                guard isTriggered else { return }
                while isTriggered {
                    updateParticles(in: geometry.size)
                    try? await Task.sleep(nanoseconds: 16_666_667)
                }
            }
        }
        
    }
    
    // Populates random particles safely within the device boundaries
    private func generateParticles(in size: CGSize) {
        var newParticles: [FloatingParticle] = []
        let particleCount = 45 // Adjust for density
        for _ in 0..<particleCount {
            let randomX = CGFloat.random(in: 30...(size.width - 30))
            // Stagger the initial starting points way below the screen threshold
            let randomY = size.height + CGFloat.random(in: 20...400)
            let randomScale = CGFloat.random(in: 0.6...1.4)
            let randomSpeed = CGFloat.random(in: 3.5...7.5)
            let randomEmoji = emojiPool.randomElement() ?? "🍪"
            
            newParticles.append(
                FloatingParticle(
                    emoji: randomEmoji,
                    xOffset: randomX,
                    yOffset: randomY,
                    scale: randomScale,
                    speed: randomSpeed
                )
            )
        }
        self.particles = newParticles
        
    }
    
    // Moves elements up, sways them horizontally, and applies fade out rules
    private func updateParticles(in size: CGSize) {
        for index in particles.indices {
            // Subtracting from Y moves items UP on iOS coordinate plane
            particles[index].yOffset -= particles[index].speed
            // Creates a gentle wave/sway motion over time using basic trigonometry
            particles[index].xOffset += sin(particles[index].yOffset / 40) * 0.7
            
            // Smoothly fade out when reaching the upper 25% of the viewport
            let fadeZone = size.height * 0.25
            if particles[index].yOffset < fadeZone {
                let progress = particles[index].yOffset / fadeZone
                particles[index].opacity = max(0, Double(progress))
            }
        }
        
        // Safety Auto-Reset: Turn toggle back off when everything clears the top bounds
        if !particles.isEmpty && particles.allSatisfy({ $0.yOffset < -60 }) {
            DispatchQueue.main.async {
                self.isTriggered = false
            }
        }
        
    }
    
}

// MARK: - 3. Demo Interface
struct CatchUpDemoView: View {
    @State private var showCelebration = false
    
    var body: some View {
        ZStack {
            // Background Layer
            Color(.systemBackground)
                .ignoresSafeArea()
            // Core UI Elements
            VStack(spacing: 24) {
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(Color.green.opacity(0.1))
                        .frame(width: 140, height: 140)
                    
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.green)
                }
                
                VStack(spacing: 8) {
                    Text("You're all caught up")
                        .font(.title2)
                        .bold()
                    
                    Text("Take a moment to enjoy the clean inbox.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Button(action: {
                    // Trigger the animation
                    showCelebration = true
                }) {
                    Text("Simulate Clear All")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(12)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 30)
            }
            
            // Interactive Celebration Overlay
            CelebrationEmitterView(isTriggered: $showCelebration)
                // Allows user touches to punch through to lower layers instantly
                .allowsHitTesting(false)
        }
        
    }
    
}

// MARK: - Preview Provider
#Preview {
    CatchUpDemoView()
}

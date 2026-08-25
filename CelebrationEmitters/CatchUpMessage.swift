//
//  CatchUpMessage.swift
//  CelebrationAnimation
//
//  Created by Nitin Bhatia on 21/08/26.
//

import SwiftUI

// MARK: - 1. Data Models
struct CatchUpMessage1: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
}

// MARK: - 2. Particle Emitter Engine
struct CelebrationEmitterViewWithScrolling: View {
    @Binding var isTriggered: Bool
    @State private var particles: [FloatingParticle] = []
    
    let emojiPool = ["🍪", "✨", "🎉", "🍪", "🔥", "🥳", "🍩", "💖"]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                TimelineView(.animation) { timeline in
                    Color.clear
                        .onChange(of: timeline.date) { _ in
                            guard isTriggered else { return }
                            updateParticles(in: geometry.size)
                        }
                }
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
        }
        
    }
    
    private func generateParticles(in size: CGSize) {
        var newParticles: [FloatingParticle] = []
        let particleCount = 45
        for _ in 0..<particleCount {
            let randomX = CGFloat.random(in: 30...(size.width - 30))
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
    
    private func updateParticles(in size: CGSize) {
        for index in particles.indices {
            particles[index].yOffset -= particles[index].speed
            particles[index].xOffset += sin(particles[index].yOffset / 40) * 0.7
            let fadeZone = size.height * 0.25
            if particles[index].yOffset < fadeZone {
                let progress = particles[index].yOffset / fadeZone
                particles[index].opacity = max(0, Double(progress))
            }
        }
        
        if !particles.isEmpty && particles.allSatisfy({ $0.yOffset < -60 }) {
            DispatchQueue.main.async {
                self.isTriggered = false
            }
        }
        
    }
    
}

// MARK: - 3. Scrollable List View
struct CatchUpListView: View {
    @State private var showCelebration = false
    @State private var safetyDebounce = false
    
    // Generate dummy items to scroll through
    @State private var messages: [CatchUpMessage1] = (1...25).map { index in
        CatchUpMessage1(
            title: "Channel Update #\(index)",
            subtitle: "This is a preview of item number \(index) in your unread stack."
        )
    }
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    LazyVStack(spacing: 0) {
                        // 1. Render all standard list messages
                        ForEach(messages) { message in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(message.title)
                                    .font(.headline)
                                Text(message.subtitle)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                Divider()
                                    .padding(.top, 12)
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                        }
                        // 2. The Final "All Caught Up" Card
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.green.opacity(0.1))
                                    .frame(width: 80, height: 80)
                                
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 44))
                                    .foregroundColor(.green)
                            }
                            
                            VStack(spacing: 4) {
                                Text("You're all caught up!")
                                    .font(.headline)
                                    .bold()
                                Text("No unread threads left.")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 40)
                        .frame(maxWidth: .infinity)
                        .onAppear {
                            triggerCelebrationOnce()
                        }
                    }
                }
                .navigationTitle("Catch Up")
            }
            
            // 3. Floating Celebration Overlay
            CelebrationEmitterViewWithScrolling(isTriggered: $showCelebration)
                .allowsHitTesting(false)
        }
        
    }
    
    // Prevents accidental double triggers when bouncing the scroll view edges
    private func triggerCelebrationOnce() {
        guard !safetyDebounce else { return }
        safetyDebounce = true
        showCelebration = true
        
        // Reset the debounce block after a short cool down period
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            safetyDebounce = false
        }
        
    }
    
}

// MARK: - Preview Provider
struct CatchUpListView_Previews: PreviewProvider {
    static var previews: some View {
        CatchUpListView()
    }
}

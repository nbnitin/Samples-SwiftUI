import SwiftUI

// MARK: - 1. Data Model

struct CatchUpMessage: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
}

// MARK: - 2. Physics Particle Model

struct JumpingParticle: Identifiable {
    let id = UUID()
    let emoji: String

    var x: CGFloat
    var y: CGFloat

    var velocityX: CGFloat
    var velocityY: CGFloat

    var scale: CGFloat

    var rotation: Double
    var rotationSpeed: Double

    // 1 = fully visible
    // 0 = completely invisible
    var opacity: Double
}

// MARK: - 3. Celebration Emitter

struct CelebrationEmitterOverlayView: View {

    @Binding var isTriggered: Bool

    @State private var particles: [JumpingParticle] = []
    @State private var lastUpdate: Date?

    // MARK: Physics

    private let gravity: CGFloat = 900

    // Bounce strength
    private let bounceStrength: CGFloat = 0.48

    // Horizontal movement
    private let horizontalDrag: CGFloat = 0.985

    // Rotation
    private let rotationDrag: CGFloat = 0.99

    // Bottom padding
    private let floorPadding: CGFloat = 30

    private let particleCount = 35

    private let emojiPool = [
        "🍪",
        "✨",
        "🎉",
        "🔥",
        "🥳",
        "🍩",
        "💖"
    ]

    var body: some View {

        GeometryReader { geometry in

            TimelineView(.animation) { timeline in

                ZStack {

                    // MARK: Particle Rendering

                    ForEach(particles) { particle in

                        Text(particle.emoji)
                            .font(.system(size: 44))
                            .scaleEffect(particle.scale)
                            .rotationEffect(
                                .degrees(particle.rotation)
                            )
                            .position(
                                x: particle.x,
                                y: particle.y
                            )
                            .opacity(particle.opacity)
                            .shadow(
                                color: .black.opacity(0.15),
                                radius: 4,
                                x: 0,
                                y: 3
                            )
                    }
                }

                // MARK: Physics Tick

                .onChange(of: timeline.date) { _, date in

                    updatePhysics(
                        currentTime: date,
                        size: geometry.size
                    )
                }
            }

            // MARK: Initial Launch

            .onAppear {

                if isTriggered {

                    launchParticles(
                        in: geometry.size
                    )
                }
            }

            // MARK: Trigger Changes

            .onChange(of: isTriggered) { _, newValue in

                if newValue {

                    launchParticles(
                        in: geometry.size
                    )

                } else {

                    particles.removeAll()
                    lastUpdate = nil
                }
            }
        }
        .allowsHitTesting(false)
    }

    // MARK: - Launch Particles

    private func launchParticles(in size: CGSize) {

        guard size.width > 80,
              size.height > 80 else {
            return
        }

        let floorY = size.height - floorPadding

        particles = (0..<particleCount).map { _ in

            JumpingParticle(

                emoji: emojiPool.randomElement()
                    ?? "🍪",

                // Random starting position
                x: CGFloat.random(
                    in: 35...(size.width - 35)
                ),

                // Start at the ground
                y: floorY,

                // Horizontal explosion
                velocityX: CGFloat.random(
                    in: -250...250
                ),

                // Upward launch
                velocityY: CGFloat.random(
                    in: -1000 ... -750
                ),

                // Random size
                scale: CGFloat.random(
                    in: 0.7...1.25
                ),

                // Random rotation
                rotation: Double.random(
                    in: 0...360
                ),

                // Rotation speed
                rotationSpeed: Double.random(
                    in: -240...240
                ),

                // Fully visible
                opacity: 1.0
            )
        }

        lastUpdate = nil
    }

    // MARK: - Physics

    private func updatePhysics(
        currentTime: Date,
        size: CGSize
    ) {

        guard isTriggered else {
            lastUpdate = currentTime
            return
        }

        guard !particles.isEmpty else {
            lastUpdate = currentTime
            return
        }

        // First frame
        guard let previousTime = lastUpdate else {

            lastUpdate = currentTime

            return
        }

        lastUpdate = currentTime

        // Time elapsed since previous frame
        let deltaTime = min(
            currentTime.timeIntervalSince(previousTime),
            1.0 / 30.0
        )

        let dt = CGFloat(deltaTime)

        let floorY = size.height - floorPadding

        for index in particles.indices {

            // MARK: Gravity

            particles[index].velocityY +=
                gravity * dt

            // MARK: Position

            particles[index].x +=
                particles[index].velocityX * dt

            particles[index].y +=
                particles[index].velocityY * dt

            // MARK: Horizontal Drag

            particles[index].velocityX *=
                pow(
                    horizontalDrag,
                    dt * 60
                )

            // MARK: Rotation

            particles[index].rotation +=
                particles[index].rotationSpeed *
                Double(dt)

            particles[index].rotationSpeed *=
                pow(
                    rotationDrag,
                    dt * 60
                )

            // MARK: Floor Collision

            if particles[index].y >= floorY {

                particles[index].y = floorY

                // Bounce
                if particles[index].velocityY > 0 {

                    particles[index].velocityY *=
                        -bounceStrength
                }

                // Friction
                particles[index].velocityX *= 0.72

                // Slow rotation
                particles[index].rotationSpeed *= 0.82
            }

            // MARK: Fade Out

            //
            // Once the particle has completed
            // its bouncing and is close to the floor,
            // gradually fade it away.
            //

            let verticalSpeed =
                abs(particles[index].velocityY)

            let horizontalSpeed =
                abs(particles[index].velocityX)

            let totalSpeed =
                verticalSpeed + horizontalSpeed

            if particles[index].y >= floorY - 5 {

                // Start fading when movement becomes slow.
                if totalSpeed < 180 {

                    particles[index].opacity -=
                        Double(dt * 0.75)
                }
            }

            // Also fade particles after they have
            // been bouncing for a while.
            if particles[index].opacity < 0.35 {

                particles[index].opacity -=
                    Double(dt * 0.35)
            }
        }

        // MARK: Remove Completely Invisible Particles

        particles.removeAll {
            $0.opacity <= 0
        }

        // Animation finished
        if particles.isEmpty {

            lastUpdate = nil

            DispatchQueue.main.async {

                if isTriggered {
                    isTriggered = false
                }
            }
        }
    }
}

// MARK: - 4. Catch Up List

struct CelebrationCatchUpListView: View {

    @State private var showCelebration = false

    @State private var safetyDebounce = false

    @State private var messages: [CatchUpMessage] =
        (1...25).map { index in

            CatchUpMessage(
                title: "Channel Update #\(index)",
                subtitle:
                    "This is a preview of item number \(index) in your unread stack."
            )
        }

    var body: some View {

        ZStack {

            // MARK: Navigation Content

            NavigationStack {

                ScrollView {

                    LazyVStack(spacing: 0) {

                        // MARK: Messages

                        ForEach(messages) { message in

                            VStack(
                                alignment: .leading,
                                spacing: 4
                            ) {

                                Text(message.title)
                                    .font(.headline)

                                Text(message.subtitle)
                                    .font(.subheadline)
                                    .foregroundColor(
                                        .secondary
                                    )

                                Divider()
                                    .padding(.top, 12)
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                        }

                        // MARK: All Caught Up

                        VStack(spacing: 16) {

                            ZStack {

                                Circle()
                                    .fill(
                                        Color.green.opacity(0.1)
                                    )
                                    .frame(
                                        width: 80,
                                        height: 80
                                    )

                                Image(
                                    systemName:
                                        "checkmark.circle.fill"
                                )
                                .font(
                                    .system(size: 44)
                                )
                                .foregroundColor(.green)
                            }

                            VStack(spacing: 4) {

                                Text(
                                    "You're all caught up!"
                                )
                                .font(.headline)
                                .bold()

                                Text(
                                    "No unread threads left."
                                )
                                .font(.subheadline)
                                .foregroundColor(
                                    .secondary
                                )
                            }
                        }
                        .padding(.vertical, 40)
                        .frame(
                            maxWidth: .infinity
                        )
                        .onAppear {

                            triggerCelebrationOnce()
                        }
                    }
                }
                .navigationTitle("Catch Up")
            }

            // MARK: Particle Overlay

            CelebrationEmitterOverlayView(
                isTriggered: $showCelebration
            )
            .allowsHitTesting(false)
        }
    }

    // MARK: - Trigger

    private func triggerCelebrationOnce() {

        guard !safetyDebounce else {
            return
        }

        safetyDebounce = true

        showCelebration = true

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 3.0
        ) {

            safetyDebounce = false
        }
    }
}

// MARK: - 5. Previews

#Preview("Emitter") {

    ZStack {

        Color.gray.opacity(0.1)
            .ignoresSafeArea()

        CelebrationEmitterOverlayView(
            isTriggered: .constant(true)
        )
    }
    .frame(
        width: 300,
        height: 600
    )
}

#Preview("Catch Up - Light") {

    CelebrationCatchUpListView()
        .frame(height: 700)
}

#Preview("Catch Up - Dark") {

    CelebrationCatchUpListView()
        .frame(height: 700)
        .environment(
            \.colorScheme,
            .dark
        )
}

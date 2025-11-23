//
//  ContentView.swift
//  ScrollableVideos
//
//  Created by Nitin Bhatia on 19/11/25.
//

import SwiftUI
import AVKit
import Combine

struct ContentView: View {
    @State private var activeVideo: MockVideo?
    @State private var mockVideos: [MockVideo] = MockVideo().generateMockVideos()
    @State private var cancellables: [UUID: AnyCancellable] = [:]
    @State private var autoScrollEnabled: Bool = true
    
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(mockVideos) { video in
                        VideoPlayer(player: video.player, videoOverlay: {
                            ZStack{
                                VStack {
                                    HStack(spacing: 40) {
                                        Text(video.title ?? "")
                                            .font(.title3)
                                            .fontWeight(.bold)
                                            .frame(height: 50)
                                    }
                                    .padding(20)
                                    .frame(width: geo.size.width, alignment: .leading)
                                }
                                .background(
                                    LinearGradient(colors: [.black.opacity(0.5), .black.opacity(0)],
                                                   startPoint: .top, endPoint: .bottom)
                                )
                                .frame(maxHeight: .infinity, alignment: .bottom)
                                
                                VStack(spacing: 30) {
                                    Button(
                                        action: {
                                            
                                        }, label: {
                                            Image(systemName: "hand.thumbsup")
                                                .tint(.white)
                                        })
                                    
                                    Button(
                                        action: {
                                            
                                        }, label: {
                                            Image(systemName: "hand.thumbsdown")
                                                .tint(.white)
                                        })
                                }
                                .padding()
                                .background(
                                    LinearGradient(colors: [.black.opacity(0.2), .black.opacity(0)],
                                                   startPoint: .top, endPoint: .bottom)
                                )
                                .frame(maxWidth: geo.size.width, alignment: .bottomTrailing)
                                //The overlay inherits the size imposed by VideoPlayer, not the one you set in .frame(height: ...). so custom height won't effect
                                
                            }
                            
                        })
                        .allowsHitTesting(false)
                        .scaledToFill()
                        .containerRelativeFrame(.vertical)
                        .id(video)
                        .onAppear {
                            if ( autoScrollEnabled ) {
                                setupEndObserver(for: video)
                            }
                        }
                        
                    }
                }
                .scrollTargetLayout()
            }
        }
        .ignoresSafeArea()
        .scrollPosition(id: $activeVideo)
        .scrollTargetBehavior(.paging)
        .onChange(of: activeVideo) { previous, current in
            previous?.player?.pause()
            current?.player?.seek(to: .zero)
            current?.player?.play()
        }
        .onAppear {
            activeVideo = mockVideos.first
        }
    }
    
    /// Auto-scroll when video ends
    private func setupEndObserver(for video: MockVideo) {
        guard cancellables[video.id!] == nil else { return }
        
        let cancellable = NotificationCenter.default
            .publisher(for: .AVPlayerItemDidPlayToEndTime, object: video.player?.currentItem)
            .sink { _ in
                withAnimation(.easeInOut(duration: 0.5)) {
                    moveToNext(video)
                }
            }
        
        cancellables[video.id!] = cancellable
    }
    
    private func moveToNext(_ current: MockVideo) {
        guard let index = mockVideos.firstIndex(of: current),
              index + 1 < mockVideos.count else {
            activeVideo = mockVideos[0] //this move back to first video once its reached to an end
            return
        }
        
        withAnimation(.easeInOut(duration: 0.5)) {
                activeVideo = mockVideos[index + 1]
        }
    }
}

struct MockVideo: Identifiable, Equatable, Hashable {
    var id: UUID?
    var title: String?
    var url: URL?
    var player: AVPlayer?
    private var playCount = 0
    
    // Combine cancellable for replay
    private var cancellable: AnyCancellable?
    private var replayCount = 0
    private var maxReplayCount: Int = 1
    
    
    init(id: UUID = UUID(), title: String, url: URL) {
        self.id = id
        self.title = title
        self.url = url
        self.player = AVPlayer(url: url)
        //        // Auto-Replay Logic using Combine
        //        self.cancellable = NotificationCenter.default
        //            .publisher(for: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem)
        //            .sink { [weak player] _ in
        //                player?.seek(to: .zero)
        //                player?.play()
        //            }
    }
    
    
    init(){}
    
    
    func generateMockURL() -> [URL] {
        return [
            Bundle.main.url(forResource: "video1", withExtension: ".mp4")!,
            Bundle.main.url(forResource: "video2", withExtension: ".mp4")!,
            Bundle.main.url(forResource: "video3", withExtension: ".mp4")!,
            Bundle.main.url(forResource: "video4", withExtension: ".mp4")!,
            Bundle.main.url(forResource: "video5", withExtension: ".mp4")!,
            Bundle.main.url(forResource: "video6", withExtension: ".mp4")!
        ]
    }
}

extension MockVideo {
    func generateMockVideos() -> [MockVideo] {
        let mockVideos = generateMockURL()
        return [
            .init(title: "Video 1", url: mockVideos[0]),
            .init(title: "Video 2", url: mockVideos[1]),
            .init(title: "Video 3", url: mockVideos[2]),
            .init(title: "Video 4", url: mockVideos[3]),
            .init(title: "Video 5", url: mockVideos[4]),
            .init(title: "Video 6", url: mockVideos[5]),
            
        ]
    }
}

#Preview {
    ContentView()
}

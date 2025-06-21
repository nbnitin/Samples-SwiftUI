//
//  ContentView.swift
//  Pull To Search
//
//  Created by Nitin Bhatia on 17/06/25.
//

import SwiftUI

struct ContentView: View {
    @State private var offsetY: CGFloat = 0
    @FocusState private var isExpanded: Bool
    @State private var originalColors: [Color: [String]] = [:]
    @State private var colors: [Color: [String]] = [:]
    @State private var searchText: String = ""
    
    var body: some View {
        
        ScrollView(.vertical) {
            DummyScrollView()
                .offset(y: isExpanded ? -offsetY : 0)
                .onGeometryChange(for: CGFloat.self) {
                    $0.frame(in: .scrollView(axis: .vertical)).minY
                } action: { newValue in
                    offsetY = newValue
                }
        }
        .overlay {
            Rectangle()
                .fill(.ultraThinMaterial)
                .background(.background.opacity(0.25))
                .ignoresSafeArea()
                .overlay {
                    if isExpanded {
                        //dummy expanded content
                        ExpandedSearchView(isExpanded: $isExpanded, colors: $colors)
                            .offset(y: isExpanded ? 0 : 70)
                            .opacity(isExpanded ? 1: 0)
                            .allowsHitTesting(true)
                        
                    }
                }
                .opacity(isExpanded ? 1: progress)
        }
        .safeAreaInset(edge: .top) {
            HeaderView()
        }
        .scrollTargetBehavior(OnScrollEnd {dy in
            if offsetY > 50 || (-dy > 1.5 && offsetY > 0) {
                isExpanded = true
            }
        })
        .animation(.interpolatingSpring(duration: 0.2), value: isExpanded)
        .onAppear {
            loadColorData()
            colors = originalColors
        }
    }
    
    
    @ViewBuilder
    func HeaderView() -> some View {
        HStack(spacing: 20) {
            if !isExpanded {
                Button {
                    
                } label: {
                    Image(systemName: "slider.horizontal.below.square.filled.and.square")
                        .font(.title3)
                }
                .transition(.blurReplace)
            }
            
            ///Search Bar
            TextField("Search App", text: $searchText)
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background {
                    ZStack {
                        Rectangle()
                            .fill(Color(.systemGray6))
                        Rectangle()
                            .fill(.ultraThinMaterial)
                    }
                    .clipShape(.rect(cornerRadius: 15))
                }
                .focused($isExpanded)
            Button {
                
            } label: {
                Image(systemName: "person.circle.fill")
                    .font(.title2)
            }
            .opacity(isExpanded ? 0: 1)
            .overlay(alignment: .trailing) {
                Button("Cancel"){
                    isExpanded = false
                    searchText = ""
                }
                .fixedSize()
                .opacity(isExpanded ? 1: 0)
                
            }
            .padding(.leading, isExpanded ? 20 : 0)
        }
        .onChange(of: searchText) {oldValue, newValue in
            filterColors(with: newValue)
        }
        .foregroundStyle(Color.primary)
        .padding(.horizontal, 15)
        .padding(.top, 10)
        .padding(.bottom, 5)
        .background {
            Rectangle()
                .fill(.background)
                .ignoresSafeArea()
            //hiding background when search bar is expanded
                .opacity(progress == 0 && !isExpanded ? 1 : 0)
        }
    }
    
    @ViewBuilder
    func DummyScrollView() -> some View {
        VStack(spacing: 16) {
            ForEach(0..<20) { index in
                Rectangle()
                    .fill(randomColor(index: index))
                    .frame(height: 150)
                    .overlay(
                        Text("Item \(index + 1)")
                            .foregroundColor(.white)
                            .font(.title)
                    )
                    .cornerRadius(12)
                    .shadow(radius: 4)
                    .padding(.horizontal)
            }
            
        }
        
    }
    
    func randomColor(index: Int) -> Color {
        // Use modulo to cycle through a fixed set of colors
        let colors: [Color] = [.red, .green, .blue, .orange, .purple, .pink, .cyan]
        return colors[index % colors.count]
    }
    
    //converting offset into progress
    var progress: CGFloat {
        return max(min(offsetY / 100, 1), 0)
    }
    
    private func loadColorData() {
        originalColors = [
            .black: ["Section 1", "Section 2", "Section 3"],
            .indigo: ["Section 4", "Section 5"],
            .cyan: ["Section 6", "Section 7"]
        ]
    }
    
    private func filterColors(with text: String) {
        if text.isEmpty {
            colors = originalColors
            return
        }

        let lowercased = text.lowercased()
        
        colors = originalColors.compactMapValues { items in
            let filtered = items.filter { $0.lowercased().contains(lowercased) }
            return filtered.isEmpty ? nil : filtered
        }
    }
}

#Preview {
    ContentView()
}

struct OnScrollEnd: ScrollTargetBehavior {
    var onEnd: (CGFloat) -> ()
    
    func updateTarget(_ target: inout ScrollTarget, context: TargetContext) {
        let dy = context.velocity.dy
        DispatchQueue.main.async {
            onEnd(dy)
        }
    }
}

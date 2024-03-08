//
//  ContentView.swift
//  StackedCards
//
//  Created by Nitin Bhatia on 07/03/24.
//

import SwiftUI

struct ContentView: View {
    
    ///View properties
    
    @State private var isRotationEnabled: Bool = true
    @State private var showIndicator: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                GeometryReader {geometry in
                    let size = geometry.size
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 0) {
                            ForEach(items) {item in
                                CardView(item)
                                    .padding(.horizontal, 65)
                                    .frame(width: size.width)
                                    .visualEffect { content, geometryProxy in
                                        content
                                            .scaleEffect(scale(geometryProxy), anchor: .trailing)
                                            .rotationEffect(rotation(geometryProxy, rotation: isRotationEnabled ? 5: 0))
                                            .offset(x: minX(geometryProxy))
                                            .offset(x: excessMin(geometryProxy, offset: isRotationEnabled ? 8 : 10))
                                    }
                                    
                                    .zIndex(items.zIndex(item)) //if we don't do that it would get behind to each other in wrong order
                            }
                        }
                        //to remove top clipping
                        .padding(.vertical, 15)
                    }
                    .scrollTargetBehavior(.paging)
                    .scrollIndicators(showIndicator ? .visible : .hidden)
                    .scrollIndicatorsFlash(trigger: showIndicator)
                   
                }
              
            }
            .frame(height: 410)
            .animation(.snappy, value: isRotationEnabled)
            VStack(spacing:8) {
                Toggle(isOn: $isRotationEnabled , label: {
                    Text("Enable Roatation")
                })
                
                Toggle(isOn: $showIndicator , label: {
                    Text("Show Scroll Indicator")
                })
            }
            .padding(15)
            .background(.bar, in: .rect(cornerRadius: 10))
            .padding(15)
            .navigationTitle("Stacked Cards")
        }
    }
    
    ///Card View
    ///
@ViewBuilder
    func CardView(_ item: Item) -> some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(item.color.gradient)
    }
    
    ///Stacked animation
    func minX(_ proxy: GeometryProxy) -> CGFloat {
        let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
        return minX < 0 ? 0 : -minX
    }
    
    ///Scaling and rotation
    ///Limit decides how many cards you want to show from trailing side
    ///
    func progress(_ proxy: GeometryProxy, limit: CGFloat = 2) -> CGFloat {
        let maxX = proxy.frame(in: .scrollView(axis: .horizontal)).maxX
        let width = proxy.bounds(of: .scrollView(axis: .horizontal))?.width ?? 0
        
        //converting into progress
        let progress = (maxX / width) - 1.0
        
        let cappedProgress = min(progress, limit)
        
        return cappedProgress
    }
    
    func scale(_ proxy: GeometryProxy, scale: CGFloat = 0.1) -> CGFloat {
        //converting into progress
        let progress = progress(proxy)
        return 1 - (progress * scale)
    }
    
    func excessMin(_ proxy: GeometryProxy, offset: CGFloat = 10) -> CGFloat {
        let progress = progress(proxy)
        return (progress * offset)
    }
    
    func rotation(_ proxy: GeometryProxy, rotation: CGFloat = 5) -> Angle {
        let progress = progress(proxy)
        return .degrees(progress * rotation)
    }
}

#Preview {
    ContentView()
}

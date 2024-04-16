//
//  ContentView.swift
//  FlipBookAnimation
//
//  Created by Nitin Bhatia on 15/04/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var progress: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                OpenableBookView(config: .init(progress: progress)){size in
                    frontView(size)
                } insideLeft: {size in
                    leftView()
                } insideRight: {size in
                    rightView()
                }
                
                Slider(value: $progress)
                    .padding(10)
                    .background(.background, in: .rect(cornerRadius: 10))
                    .padding(.top, 50)
                
                Button(progress == 1.0 ? "Close Book" : "Open Book", action: {
                    withAnimation(.snappy(duration: 1.0), {
                        progress = (progress == 1.0 ? 0 : 1.0)
                    })
                    
                })
                .padding(.top, 10)
            }
            .padding(15)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.red.opacity(0.15))
            .navigationTitle("Book View")
        }
        
    }
    
    ///Front View
    @ViewBuilder
    func frontView(_ size: CGSize) -> some View {
        Image(.bookCover)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size.width, height: size.height)
    }
    
    
    
    ///Left View
    @ViewBuilder
    func leftView() -> some View {
        VStack {
            Image(.author)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
                .clipShape(.circle)
                .shadow(color: /*@START_MENU_TOKEN@*/.black/*@END_MENU_TOKEN@*/.opacity(0.15), radius: 5, x: 5, y: 5)
            
            Text("Hello All")
                .fontWidth(.condensed)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background)
        .scaleEffect(x: -1)
        
    }
    
    ///Right View
    @ViewBuilder
    func rightView() -> some View {
        VStack(alignment: .leading, spacing: 8, content: {
            Text("What is Lorem Ipsum?")
                .font(.system(size: 14))
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                .font(.caption)
                .foregroundStyle(.gray)
            
        })
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.background)
    }
}

//interactive book card view

//As you can see, the front view was flipped immediately when the button was pressed.
//This is because SwiftUl animates the value of progress from 0 to directly 1, rather than progressing from 0 to 1. However, we can solve this by using the Animatable Protocol to convert this progress into animatable data, which will cause the progress to progressively go from 0 to 1 rather than jumping directly from 0 to 1.

struct OpenableBookView<Front: View, InsideLeft: View, InsideRight: View>: View, Animatable {
    var config: Config = .init()
    @ViewBuilder var front: (CGSize) -> Front
    @ViewBuilder var insideLeft: (CGSize) -> InsideLeft
    @ViewBuilder var insideRight: (CGSize) -> InsideRight
    
    var animatableData: CGFloat {
        get { config.progress }
        set { config.progress = newValue }
    }
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            //limiting progress from 0-1
            let progress = max(min(config.progress, 1),0)
            let rotation = progress * -180
            let cornerRadius = config.cornerRadius
            let shadowColor = config.shadowColor
            let dividerBackground = config.dividerBackground
            
            ZStack {
                insideRight(size)
                    .frame(width: size.width, height: size.height)
                    .clipShape(.rect(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: cornerRadius,
                        topTrailingRadius: cornerRadius
                    ))
                    .shadow(color: shadowColor.opacity(0.2 * progress), radius: 5, x: 5, y: 5)
                    .overlay(alignment: .leading, content: {
                        Rectangle()
                            .fill(config.dividerBackground.shadow(.inner(color: shadowColor.opacity(0.15), radius: 2)))
                            .frame(width: 6)
                            .offset(x: -3)
                            .clipped()
                    })
                
                front(size)
                    .frame(width: size.width, height: size.height)
                //disabling interaction once flipped
                    .allowsHitTesting(-rotation < 90)
                
                    .overlay(content: {
                        if progress >= 0.5 || -rotation > 90 {
                            insideLeft(size)
                                .frame(width: size.width, height: size.height)
                            //to reflipped again, we need to apply negative rotation so we are apply scaling effect
                                .transition(.identity)
                            
                        }
                    })
                    .clipShape(.rect(
                        topLeadingRadius: 0,
                        bottomLeadingRadius: 0,
                        bottomTrailingRadius: cornerRadius,
                        topTrailingRadius: cornerRadius
                    ))
                    .shadow(color: shadowColor.opacity(0.2), radius: 5, x: 5, y: 5)
                //since the root view has been flipped here, so it will make overlay to be flipped too
                    .rotation3DEffect(
                        .init(degrees: rotation),
                        axis: (x: 0, y: 1, z:0),
                        anchor: .leading,
                        perspective: 0.3
                        
                    )
                
                    
                    
                
            }
            
            .offset(x: (config.width / 2) * progress) //centring book when opened
            
        }
        .frame(width: config.width, height: config.height)
    }
    
    
    //configuration
    struct Config {
        var width: CGFloat = 150
        var height: CGFloat = 240
        var progress: CGFloat = 0
        var cornerRadius: CGFloat = 10
        var shadowColor: Color = .black
        var dividerBackground: Color = .white
    }
}

#Preview {
    ContentView()
}

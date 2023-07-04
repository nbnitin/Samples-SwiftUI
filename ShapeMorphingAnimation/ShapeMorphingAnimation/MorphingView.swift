//
//  MorphingView.swift
//  ShapeMorphingAnimation
//
//  Created by Nitin Bhatia on 04/07/23.
//

import SwiftUI

struct MorphingView: View {
    //MARK: view properties
    @State var currentImage: CustomShape = .bell
    @State var pickerImage: CustomShape = .bell
    @State var turnOffImageMorph: Bool = false
    @State var blurRadius: CGFloat = 10
    @State var animateMorph: Bool = false
    var body: some View {
        
        VStack {
            //MARK: image morph is simple
            //Simply mask the canvas shape with Image mask
            
            GeometryReader {proxy in
                let size = proxy.size
                Image("pic2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(x: -20, y: 40)
                    .frame(width: size.width, height: size.height)
                    .clipped()
                    .overlay(content: {
                        Rectangle()
                            .fill(.white)
                            .opacity(turnOffImageMorph ? 1 : 0)
                    })
                    .mask({
                        //MARK: Morphing shapes with the help of canvas and filters
                        Canvas{context, size in
                            //MARK: morhphing filters
                            //For more morph shape link
                            //MARK: For more Morph shape link change this
                            context.addFilter(.alphaThreshold(min: 0.4))
                            //MARK: this value plays major role in the morphing animation
                            
                            //MARK: For reverse animation
                            //Until 20 -> It will be like 0 - 1
                            //After 20 Till 40 -> It will be like 1-0
                            context.addFilter(.blur(radius: blurRadius >= 20 ? 20 - (blurRadius - 20) : blurRadius))
                            
                           //MARK: draw inside layer
                            context.drawLayer { ctx in
                                if let resolvedImage = ctx.resolveSymbol(id: 1) {
                                    ctx.draw(resolvedImage , at: CGPoint(x: size.width / 2, y: size.height / 2), anchor: .center)

                                }
                            }
                           
                        } symbols: {
                            //MARK: giving image with ID
                            ResolvedImage(currentImage: $currentImage)
                                .tag(1)
                        }
                        //MARK: animation will not work in the canvas
                        //we can use timeline view for those animation
                        //But here we are going to use timer for same effect
                        //The timer count is actually employed to increase speed. As an illustration, choose 0.0007 for the ideal animation speed.
                        .onReceive(Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()) {_ in
                            if animateMorph {
                                if blurRadius <= 40 {
                                    // This is animation speed
                                    //you can change this for your own
                                    blurRadius += 0.5
                                    
                                    if blurRadius.rounded() == 20 {
                                        //MARK: change of next image goes here
                                        currentImage = pickerImage
                                    }
                                    
                                }
                                
                                if blurRadius.rounded() == 40 {
                                    //MARK: End animation and reset the blur radius to zero
                                    animateMorph = false
                                    blurRadius = 0
                                }
                            }
                        }
                        .frame(height: 400)
                    })
            }
            
           
            //MARK: segmented picker
            Picker("", selection: $pickerImage) {
                ForEach(CustomShape.allCases, id: \.rawValue) {shape in
                    Image(systemName: shape.rawValue)
                        .tag(shape)
                }
            }
            .pickerStyle(.segmented)
            //MARK: avoid tap until current animation is finished
            .overlay(content: {
                Rectangle()
                    .fill(.primary)
                    .opacity(animateMorph ? 0.05 : 0 )
            })
            .padding(15)
            .padding(.top, -50)
            .onChange(of: pickerImage) {newValue in
                animateMorph = true
                
            }

            Toggle("Turn Off Image Morph", isOn: $turnOffImageMorph)
                .fontWeight(.semibold)
                .padding(.horizontal, 15)
                .padding(.top, 10)
            
           // Slider(value: $blurRadius, in: 0...40)
        }
        .offset(y: -50)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

struct ResolvedImage: View {
    @Binding var currentImage: CustomShape
    var body: some View {
        Image(systemName: currentImage.rawValue)
            .font(.system(size: 200))
            .animation(.interactiveSpring(response: 0.7, dampingFraction: 0.8,blendDuration: 0.8), value: currentImage)
            .frame(width: 300, height: 300)
    }
}

struct MorphingView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

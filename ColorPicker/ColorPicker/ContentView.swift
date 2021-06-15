//
//  ContentView.swift
//  ColorPicker
//
//  Created by Nitin Bhatia on 6/15/21.
//

import SwiftUI

struct ContentView: View {
    var radius : CGFloat = 150
    var diameter : CGFloat {
        radius * 2
    }
    //unset initial value to hide color picker in starting of view...
    
    //once hide it will be shown when user start dragging
    @State private var startLocation : CGPoint? = CGPoint(x:UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
    @State private var location : CGPoint? =  CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2)
    
    //adding dynamic background color
    @State private var bgColor = Color.green
    
    init() {
        startLocation = CGPoint(x: 100, y: 100)
        location = CGPoint(x: 50, y: 50)
    }
   
    
    var body: some View {
        ZStack{
            if startLocation != nil {
                Circle()
                    //adding color wheel
                    .fill (
                        AngularGradient(gradient: Gradient(colors: [
                                                            Color(hue: 1.0, saturation: 1, brightness: 0.9),
                                                            Color(hue: 0.9, saturation: 1, brightness: 0.9),
                                                            Color(hue: 0.8, saturation: 1, brightness: 0.9),
                                                            Color(hue: 0.7, saturation: 1, brightness: 0.9),
                                                            Color(hue: 0.6, saturation: 1, brightness: 0.9),
                                                            Color(hue: 0.5, saturation: 1, brightness: 0.9),
                                                            Color(hue: 0.4, saturation: 1, brightness: 0.9),
                                                            Color(hue: 0.3, saturation: 1, brightness: 0.9),
                                                            Color(hue: 0.2, saturation: 1, brightness: 0.9),
                                                            Color(hue: 0.1, saturation: 1, brightness: 0.9)]), center: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                    )
                    .frame(width: diameter, height: diameter)
                    .overlay(
                        Circle()
                            .fill(
                                RadialGradient(gradient: Gradient(colors: [Color.white, Color.white.opacity(0.00001)]), center: .center, startRadius: 0, endRadius: radius)
                            )
                    )
                    .position(startLocation!)
                    .shadow(color: Color.black.opacity(0.1), radius: 6, y: 8)
                
                //handle
                Circle()
                    .frame(width: 50, height: 50)
                    .position(location!)
                    .foregroundColor(.black)
            }
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(bgColor)
        .gesture(dragGesture)
        .ignoresSafeArea()
    }
    
    //drag action
    var dragGesture:some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged{val in
                if startLocation == nil {
                    startLocation = val.location
                }
                //now we have to clamp handle with circle so that it can't move out of our color picker
                let distanceX = val.location.x - startLocation!.x
                let distanceY = val.location.y - startLocation!.y
                
                let dir = CGPoint(x: distanceX, y: distanceY)
                var distance = sqrt(distanceX * distanceX + distanceY * distanceY)
                
                if distance < radius {
                    location = val.location
                } else {
                    let clampedX = dir.x / distance * radius
                    let clampedY = dir.y / distance * radius
                    location = CGPoint(x: startLocation!.x + clampedX, y: startLocation!.y + clampedY)
                    distance = radius
                }
                
                //calculating the color value
                
                if distance == 0 {
                    return
                }
                
                var angle = Angle(radians: -Double(atan(dir.y / dir.x)))
                
                if dir.x < 0 {
                    angle.degrees += 180
                } else if dir.x > 0 && dir.y > 0 {
                    angle.degrees += 360
                }
                let hue = angle.degrees / 360
                let staturation = Double(distance / radius)
                bgColor = Color(hue: hue, saturation: staturation, brightness: 0.7)
            }
            .onEnded{ val in
                //uncomment to hide in starting of app
                
                //startLocation = nil
                //location = nil
                
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

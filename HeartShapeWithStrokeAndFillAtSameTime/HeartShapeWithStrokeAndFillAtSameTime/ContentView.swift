//
//  ContentView.swift
//  HeartShapeWithStrokeAndFillAtSameTime
//
//  Created by Nitin Bhatia on 4/23/21.
//

import SwiftUI

extension Shape {
    func fill<Fill: ShapeStyle, Stroke: ShapeStyle>(_ fillStyle: Fill, strokeBorder strokeStyle: Stroke, lineWidth: CGFloat = 1) -> some View {
        self
            .stroke(strokeStyle, lineWidth: lineWidth)
            .background(self.fill(fillStyle))
    }
}

struct ContentView: View {
    
    var body: some View {
        VStack{
       //not possible to use fill and stroke at same time, this problem resolved by using extension
            Shape2()
                .fill(Color.red, strokeBorder: Color.black, lineWidth: 3)
            // .fill(Color.red)
                // .stroke(Color.black,lineWidth: 3)
                .frame(height:500)
                .background(Color.green)
           
           
                
        }
    }
}

struct Shape2: Shape {
    
    
    func path(in rect: CGRect) -> Path {

        let startPoint1 = CGPoint(x: rect.midX, y: 90)
        let startPoint2 = CGPoint(x: rect.midX+2, y: rect.midY)
        
        let controlPoint1 = CGPoint(x: rect.midX - 90, y: 200)
        let controlPoint2 = CGPoint(x: rect.midX - 90, y:-40)
        
        let controlPoint3 = CGPoint(x:rect.midX + 90, y: -40)
        let controlPoint4 = CGPoint(x: rect.midX + 90, y: 200)
        
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        
       
        //left side
        path.addCurve(to:startPoint1,
                      control1: controlPoint1,
                              control2: controlPoint2)
        
        //right side
        path.addCurve(to: startPoint2,
                      control1: controlPoint3,
                              control2: controlPoint4)
        
            
        return path
    }
    
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

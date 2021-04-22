//
//  SmileyView.swift
//  Smiley
//
//  Created by Nitin Bhatia on 4/22/21.
//

import SwiftUI

struct SmileyView: Shape {
    var yOffset: CGFloat = 10
    
    func path(in rect: CGRect) -> Path {
        let spacing: CGFloat = 180
        var path = Path()
        path.addPath(getEye(_path: path, rect: rect))
       path = path.applying(.init(scaleX: -1, y: 1))
        path = path.applying(.init(translationX: rect.maxX - spacing, y: 0))
        
        path.addPath(getEye(_path: path, rect: rect))
         path = path.applying(.init(translationX: spacing / 2, y: 0))
        path = path.applying(.init(translationX: 0, y: -150))
        path.addPath(getMouth(_path: path, rect: rect))
        return path
    }
    
    func getMouth(_path:Path, rect: CGRect) -> Path {
        var path = _path
        let startPoint = CGPoint(x: rect.minX, y: rect.midY)
        let endPoint = CGPoint(x: rect.maxX, y: rect.midY)
        let contolPoint1 = CGPoint(x:startPoint.x + 10, y: rect.midY + yOffset)
        let contolPoint2 = CGPoint(x:endPoint.x + 10, y: rect.midY + yOffset)
        path.move(to: startPoint)
      //  path.addLine(to: endPoint)
        path.addCurve(to: endPoint, control1: contolPoint1, control2: contolPoint2)
        return path
        
    }
    
    func getEye(_path:Path, rect: CGRect)->Path {
        var path = _path
        
        let startPoint = CGPoint(x: rect.midX - 50, y: rect.midY)
        let bottomPoint = CGPoint(x: startPoint.x + 50, y: startPoint.y + 50)
        let controlPoint1 = CGPoint(x: startPoint.x, y: bottomPoint.y)
        let rightPoint = CGPoint(x: startPoint.x + 100, y: startPoint.y - 30)
        let controlPoint2 = CGPoint(x: rightPoint.x, y: bottomPoint.y)
        let offset: CGFloat = yOffset / 5
        let controlPoint3 = CGPoint(x: rightPoint.x - 5, y: rightPoint.y + offset)
        let controlPoint4 = CGPoint(x: startPoint.x + 5, y: startPoint.y - offset)
        path.move(to: startPoint)
        
        path.addQuadCurve(to: bottomPoint, control: controlPoint1)
        path.addQuadCurve(to: rightPoint, control: controlPoint2)
        
        /* code to test points starts */
//        let size = CGSize(width: 5, height: 5)
//        path.addEllipse(in: CGRect(origin: controlPoint1, size: size))
//        path.addEllipse(in: CGRect(origin: controlPoint2, size: size))
        
        /* code to test points ends */
        
        path.addCurve(to: startPoint, control1: controlPoint3, control2: controlPoint4)
        return path
        
    }
}

struct SmileyView_Previews: PreviewProvider {
    static var previews: some View {
        SmileyView(yOffset: 10)
    }
}

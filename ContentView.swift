//
//  ContentView.swift
//  StickyEffect
//
//  Created by Nitin Bhatia on 21/06/23.
//

import SwiftUI

struct ContentView: View {
    let centerWidth = UIScreen.main.bounds.width / 2
    let centerHeight = UIScreen.main.bounds.height / 2
    
    @State var position = CGSize(width: 0, height: 0)
    
    var body: some View {
        
        Canvas {context, size in
//            context.fill(Path(CGRect(origin: .zero, size: size)), with: .color(Color(.sRGB, red: 230/255, green: 240/255, blue: 1, opacity: 1.0)))
            
        

            let firstCircle = context.resolveSymbol(id: 0)!
            let secondCircle = context.resolveSymbol(id: 1)!
            
            context.addFilter(.alphaThreshold(min: 0.2))
            context.addFilter(.blur(radius: 20))
            
            context.drawLayer{ context2 in
                context2.draw(firstCircle, at: .init(x: centerWidth, y: centerHeight))
                context2.draw(secondCircle, at: .init(x: centerWidth, y: centerHeight))
                
            }
        } symbols: {
            //we have to register shapes or views here, which will be later drawn in canvas.
            //each view or shape will have tag id
            Circle()
                .fill(.blue)
               
                .frame(width: 40,height: 40,alignment: .center)

                //.frame(width: 150, height: 150)
                .tag(0)
            Circle()
                //.stroke(.red, lineWidth: 20)
                .frame(width: 40,height: 40,alignment: .center)
                .offset(x: position.width,y: position.height)
                .tag(1)
        }
//        .background(Color.red)
        .gesture(DragGesture().onChanged({gesture in
            self.position = gesture.translation
            
        }).onEnded({gesture in
            self.position = .zero
        }))
        .animation(.spring(), value: position)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

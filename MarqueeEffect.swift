//
//  ContentView.swift
//  MarqueeEffect
//
//  Created by Nitin Bhatia on 27/06/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 22) {
                
                GeometryReader { geo in
                    
                    let size = geo.size
                    
                    
                    Image("postImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size.width, height: size.height)
                        .cornerRadius(15)
                    
                }
                .frame(height: 220)
                .padding(.horizontal)
                
                Marquee(text:"Tech, video games, failed cooking attempts, vlogs, and more!", font: .systemFont(ofSize: 14, weight: .regular))
                
                
                
            }
            .padding(.vertical)
            .navigationTitle("Marquee text")
        }
        

    
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


//MARK: marquee text view

struct Marquee : View {
    
   @State var text : String
    
    var font: UIFont
    
    //Storing text size
    
    @State var  storedSize: CGSize = .zero
    
    //MARK: Animation offset
    @State var offset: CGFloat = 0
    
    //MARK: animation speed
    var animationSpeed: Double = 0.01
    
    //MARK: delay time
    var delayTime: Double = 0.5
    
    @Environment(\.colorScheme) var scheme
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            Text(text)
                .font(Font(font))
                .offset(x:offset)
                .padding(.horizontal, 15)
        }
        
        .overlay(content: {
            HStack {
                let color : Color = scheme == .dark ? .black : .white
                LinearGradient(colors: [color, color.opacity(0.7), color.opacity(0.5),color.opacity(0.3)], startPoint: .leading, endPoint: .trailing)
                    .frame(width: 20)
                Spacer()
                LinearGradient(colors: [color, color.opacity(0.7), color.opacity(0.5),color.opacity(0.3)].reversed(), startPoint: .leading, endPoint: .trailing)
                    .frame(width: 20)
            }
        })
        
        //disabling scrolling
        .disabled(true)
        .onAppear {
            //base text

            let baseText = text


            (1 ... 15).forEach({_ in
                text.append(" ")
            })

//            stopping animation exactly before the next text
            storedSize = textSize()
            
            
            text.append(baseText)
           // calculating total secs based on text width
            // Our animation speed for each character will be 0.02s
            let timing : Double = (animationSpeed * storedSize.width)
            
            //delaying first animation
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                withAnimation(.linear(duration: timing)) {
                    offset = -storedSize.width
                }
            }
        }
        
        //MARK: repeating animation
        .onReceive(Timer.publish(every: animationSpeed * storedSize.width, on: .main, in: .default).autoconnect()) {_ in
            //resetting offset  to 0
            //thus it look like its looping
            offset = 0
            withAnimation(.linear(duration: (animationSpeed * storedSize.width) + 0.5)) {
                offset = -storedSize.width
            }
        }
    }
    
    //MARK: fetching text size for offset animation
    
    func textSize() -> CGSize {
        let attributes = [NSAttributedString.Key.font: font]
        let size = (text as NSString).size(withAttributes: attributes)
        
        return size
    }
}

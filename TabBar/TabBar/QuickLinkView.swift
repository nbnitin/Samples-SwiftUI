//
//  QuickLinkView.swift
//  TabBar
//
//  Created by Nitin Bhatia on 23/09/22.
//

import SwiftUI

//struct AnimatingCellHeight: AnimatableModifier {
//    var scale: CGFloat = 0
//
//    var animatableData: CGFloat {
//        get { height }
//        set { height = newValue }
//    }
//
//    func body(content: Content) -> some View {
//        content.scaleEffect(sca)
//    }
//}

struct QuickLinkView: View {
    private var scalingFactor: CGFloat = 0.5
    private var hasDot : Bool = true
    @State private var shouldAnimate2 = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()


    var body: some View {
        
        
        ZStack {
            VStack(alignment: .leading) {
                Image("Image")
                    .resizable()
                    .frame(height: 67)
                
                Text("Weekly Explained Videos")
                    .font(.system(size: 12))
                    .padding(.leading,4)
                if hasDot {
                    Image("Group 22")
                        .onReceive(timer) {_ in
                            let animation = Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)
                            withAnimation(animation){
                                shouldAnimate2.toggle()
                            }
                        }
                       // .modifier(<#T##modifier: T##T#>)
                        .scaleEffect(shouldAnimate2 ? 1.4 : 1)
                        .offset(x:105,y:-110)
                    
                }
           }
            
        }
        .frame(width: 120,height: 130)
        .border(Color(red: 239, green: 239, blue: 230),width: 1)
        .background(
            Color.white // any non-transparent background
                .shadow(color: Color.gray, radius: 6, x: 0, y: 2)
        )
    }
        
    
}


struct QuickLinkView_Previews: PreviewProvider {
    static var previews: some View {
        QuickLinkView()
    }
}

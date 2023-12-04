//
//  DropDownView.swift
//  DropDown
//
//  Created by Nitin Bhatia on 28/11/23.
//

import SwiftUI

struct DropDownView: View {
    //customization properties
    var hint: String
    var options: [String]
    var anchor: Anchor = .bottom
    var maxWidth: CGFloat = 180
    var cornerRadius: CGFloat = 15
    @Binding var selection: String?
    
    //view properties
    @State private  var showOptions: Bool = false
    //Environment Scheme
    @Environment(\.colorScheme) private var scheme
    @SceneStorage("drop_down_zindex") private var index = 1000.0
    @State var zIndex: Double = 1000.0
    
    var body: some View {
        GeometryReader{
            let size = $0.size
            VStack(spacing: 0) {
                
                if showOptions && anchor == .top {
                    optionView()
                }
                HStack(spacing:0, content: {
                    Text(selection ?? hint)
                        .foregroundStyle(selection == nil ? .gray : .primary)
                    Spacer(minLength: 0)
                    Image(systemName: "chevron.down")
                        .font(.title3)
                        .foregroundColor(.gray)
                    //rotating icon
                        .rotationEffect(.init(degrees: showOptions ? -180 : 0))
                })
                .padding(.horizontal, 15)
                .frame(width: size.width,height: size.height)
                .background(scheme == .dark ? .black : .white)
                .contentShape(.rect)
                .onTapGesture {
                    //we are incresing zIndex by 1 of current selected dropdown becuase it was going being to other dropdown.
                    index += 1
                    zIndex = index
                    withAnimation(.snappy) {
                        showOptions.toggle()
                    }
                    
                }
                .zIndex(10)
                
                if showOptions && anchor == .bottom {
                    optionView()
                }
            }
            .clipped()
            .contentShape(.rect) //Clips all interaction within its bounds
            .background((scheme == .dark ? Color.black : Color.white).shadow(.drop(color:.primary.opacity(0.15) ,radius: 4)), in: .rect(cornerRadius: cornerRadius))
            .frame(height: size.height, alignment: anchor == .top ? .bottom : .top)
        }
        .frame(width: maxWidth, height: 50)
        .zIndex(zIndex)
    }
    
    //option view
    @ViewBuilder
    func optionView() -> some View {
        VStack(spacing: 10, content: {
            ForEach(options, id: \.self) {option in
                HStack(spacing: 0, content: {
                    Text(option)
                        .lineLimit(1)
                    Spacer(minLength: 0)
                    Image(systemName: "checkmark")
                        .font(.caption)
                        .opacity(selection == option ? 1 : 0)
                })
                .foregroundColor(selection == option ? .primary : .gray)
                .animation(.none, value: selection)
                .frame(height: 40)
                .contentShape(.rect)
                .onTapGesture {
                    withAnimation(.snappy) {
                        selection = option
                        showOptions = false
                    }
                }
            }
        })
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
        //adding transition
        .transition(.move(edge: anchor == .top ? .bottom : .top))
    }
    
    enum Anchor: String {
        case top
        case bottom
    }
}

#Preview {
   ContentView()
}

//
//  PickerView.swift
//  CustomPicker
//
//  Created by Nitin Bhatia on 24/01/26.
//


import SwiftUI



struct CustPickerView: View {
    @Binding var editMode: Bool
    @State var title: String = ""
    @State private var scrollID: String? = nil
    @Binding var selectedValue: String
    @State var values : [String]
    @State var isLeft: Bool = false
    @State var fullWidth: Bool = false
    
    func shape(edit: Bool, isLeft: Bool) -> UnevenRoundedRectangle {
        if editMode {
            return UnevenRoundedRectangle(topLeadingRadius: 12, bottomLeadingRadius: 12, bottomTrailingRadius: 12, topTrailingRadius: 12)
        } else {
            if isLeft {
                return UnevenRoundedRectangle(topLeadingRadius: 12, bottomLeadingRadius: 12, bottomTrailingRadius: 0, topTrailingRadius: 0)
            } else {
                return UnevenRoundedRectangle(topLeadingRadius: 0, bottomLeadingRadius: 0, bottomTrailingRadius: 0, topTrailingRadius: 0)
            }
        }
    }
    
    var body: some View {
        HStack(spacing: editMode ? 5 : 0) {
            ZStack {
                ScrollViewReader {proxy in
                    ScrollView {
                        LazyVStack(spacing: -30) {
                            ForEach(values, id: \.self) {value in
                                Text(String(value))
                                    .font(.system(size: 25))
                                    .bold()
                                    .frame(height: 70)
                                    .foregroundStyle(selectedValue == value ? Color.primary : .gray)
                                    .id(value)
                                    .opacity(selectedValue == value ? 1 : (editMode ? 1 : 0000.01))
                                    .scrollTransition(axis: .vertical) {effect, phase in
                                        effect.scaleEffect((phase.isIdentity ? 1.0 : 0.1))
                                    }
                            }
                        }
                        .scrollTargetLayout()
                    }
                    .scrollIndicators(.hidden)
                    .scrollTargetBehavior(.viewAligned)
                    .safeAreaPadding(.vertical, 15)
                    .scrollPosition(id: $scrollID, anchor: .center)
                    .allowsHitTesting(editMode)
                    .onScrollPhaseChange { _, newPhase in
                        guard newPhase == .idle else { return }

                        if selectedValue != "" {
                            withAnimation(.easeOut(duration: 0.1)) {
                                proxy.scrollTo(selectedValue, anchor: .center)
                            }
                        }
                    }
                    .onAppear {
                        scrollID = selectedValue
                        DispatchQueue.main.async {
                            proxy.scrollTo(selectedValue, anchor: .center)
                        }
                    }
                    .onChange(of: editMode) {
                        DispatchQueue.main.async {
                            proxy.scrollTo(selectedValue, anchor: .center)
                        }
                    }
                    .onChange(of: scrollID) { _, newID in
                        if let newID {
                            withAnimation(.easeOut(duration: 0.15)) {
                                selectedValue = newID
                            }
                        }
                    }
                }
            }
            .frame(width: fullWidth ? .infinity : 40, height: 100)
            Text(title)
                .font(.system(size: 25))
                .bold()
                .foregroundStyle(.gray)
        }
            .padding(.trailing, 3)
            .padding(editMode ? .horizontal : .leading, 10)
            .frame(height: editMode ? 105 : 60)
            .clipped()
            .background(BG.teritary, in: shape(edit: editMode, isLeft: isLeft))
        
    }
}

#Preview {
    ContentView()
}

//
//  ContentView2.swift
//  TabBar
//
//  Created by Nitin Bhatia on 22/09/22.
//

import SwiftUI



struct CompositeLayout: View {
    private var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    @State var learnWithLessons : Int = 6

    var body: some View {
        List {
            Section {
                VStack(alignment:.leading) {
                    Text("Current Affairs")
                    ScrollView(.horizontal,showsIndicators: false) {
                        LazyHStack(alignment:.top) {
                            ForEach((1...10), id: \.self) {_ in
                                QuickLinkView()

                                padding(.leading,12)
                            }
                        }
                    }
                }
            }
            .listRowSeparator(.hidden)
            
            Section {
                VStack(alignment:.leading,spacing: 16) {
                    Text("Learn with Video Lessons")
                    LazyVGrid(columns: threeColumnGrid,spacing: 28) {
                        
                        ForEach(0 ..< learnWithLessons,id: \.self) {_ in
                            LearnWithVideo()
                        }
                        
                    }
                    
                    HStack(alignment: .center){
                        Spacer()
                        Button {
                            if learnWithLessons > 6 {
                                learnWithLessons = 6
                            } else {
                                learnWithLessons += 6
                            }
                            
                        } label: {
                            HStack(alignment: .center) {
                                
                                Text("View All")
                                    .padding(.leading, 4)
                                    .padding(.top, 4)
                                    .padding(.bottom, 4)
                                
                                    .font(.system(size: 14))
                                
                                Image(systemName: learnWithLessons > 6 ? "chevron.up" : "chevron.down")
                                    .padding(.trailing, 4)
                                    .padding(.top, 4)
                                    .padding(.bottom, 4)
                            }
                        }
                        .buttonStyle(.plain)
                        
                        .frame(width:88,height: 24)
                        .border(Color.green,width:1)
                        .background(Color.white)
                        .cornerRadius(15.5)
                        Spacer()
                    }
                    
                }
            }
            .listRowSeparator(.hidden)
            .padding()
            .background(Color.red)
            
            Section {
                VStack(alignment: .leading) {
                    HStack {
                        Text("Popular Lessons")
                            .bold()
                        Spacer()
                        Button {
                            print("View All tapped Popular")
                        } label: {
                            Text("View All")
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.leading,-10)
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack {
                            ForEach(1 ..< 5) {_ in
                                VideoThumbnailView()
                            }
                        }
                    }
                    .padding(.leading, -10)
                }
                
            }
            .listRowSeparator(.hidden)
            .padding()
            .background(Color.white)
        }
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
        .navigationTitle("Composite")
        .navigationBarTitleDisplayMode(.inline)
        
        
    }
    
    
}

struct CompositeLayout_Previews: PreviewProvider {
    static var previews: some View {
        CompositeLayout()
    }
}

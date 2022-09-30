//
//  LandMarkListView.swift
//  PracticeSwiftUI
//
//  Created by Nitin Bhatia on 15/09/22.
//

import SwiftUI

struct LandMarkListView: View {
    var body: some View {
        NavigationView {
            List (landmarks){ items in
                
                ZStack {
                    
                        LandMarkRowView(landmark: items)
                        
                        NavigationLink(destination:
                                        ContentView(landMarks: items)
                        ) {
                            EmptyView()
                        }
                        .buttonStyle(PlainButtonStyle()).frame(width:0).opacity(0)
                    
                    
                    
                }
                
                
            }
            .navigationTitle("LandMarks")
            .navigationBarTitleDisplayMode(.inline)
            .scrollIndicators(.hidden)
            .listStyle(PlainListStyle())
             //GroupedListStyle()
        }
    }
}

struct LandMarkListView_Previews: PreviewProvider {
    static var previews: some View {
        LandMarkListView()
    }
}

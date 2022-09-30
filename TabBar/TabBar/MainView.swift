//
//  MainView.swift
//  TabBar
//
//  Created by Nitin Bhatia on 21/09/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            //navigation view should be only one for whole app
            NavigationView {
                ContentView()
            }
                    .tabItem {
                        Label("Table Framework 1", systemImage: "list.bullet.rectangle.portrait")
                    }
            
            NavigationView {
                CompositeLayout()
            }
                    .tabItem {
                        Label("Composite", systemImage: "list.bullet.rectangle.portrait")
                    }
            
            NavigationView {
                Premium()
            }
                    .tabItem {
                        Label("Premium", systemImage: "list.bullet.rectangle.portrait")
                    }
            
            
               
            NavigationView {
                ProfileView()
            }
                    .tabItem {
                        Label("Profile", systemImage: "list.bullet.rectangle.portrait")
                    }
            
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

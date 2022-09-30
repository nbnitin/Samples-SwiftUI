//
//  ProfileView.swift
//  TabBar
//
//  Created by Nitin Bhatia on 26/09/22.
//

import SwiftUI

struct ProfileView: View {
    
    @State private var toggleOn : Bool = true
    
    var body: some View {
        
            List {
                VStack {
                    Text("Profile")
                        .frame(maxWidth: .infinity,alignment: .center)
                    Spacer(minLength: 30)
                    Image("Image")
                        .resizable()
                        .frame(width: 80,height: 80)
                        .cornerRadius(40)
                    Text("Nitin Bhatia")
                        .padding(.bottom,0.6)
                    Text("+91999999999")
                        .padding(.bottom,32)
                    Text("Exam Preference")
                        .frame(maxWidth: .infinity,alignment: .leading)
                    Spacer()
                    Group {
                        HStack {
                            Text("CAT & MBA")
                            Spacer()
                            
                            Button {
                                print("Change button tapped")
                            } label: {
                                Text("Change")
                                    .foregroundColor(.red)
                            }
                            .buttonStyle(.plain)
                        }
                        .frame(height: 44)
                        Divider()
                            .background(Color.red)
                    }
                    
                    Group {
                        VStack {
                            Text("Settings")
                                .frame(maxWidth: .infinity,alignment: .leading)
                        }
                        .padding(.bottom,-8)
                        
                        HStack {
                            Text("Help and Feedback")
                            
                            Spacer()
                            
                            
                        }
                        .frame(height: 44)
                        Divider()
                            .background(Color.red)
                        
                        
                        HStack {
                            
                            Toggle(isOn: $toggleOn) {
                                Text("Notification")
                            }
                               
                            .frame(height: 44)
                            .onReceive([toggleOn].publisher.first()) { (value) in
                                    print("New value is: \(value)")
                               }
                            
                        }
                        Divider()
                            .background(Color.red)
                        
                        HStack {
                            Text("Terms & Conditions")
                            
                            Spacer()
                            
                            
                            .frame(height: 44)
                            
                        }
                        Divider()
                            .background(Color.red)
                        
                        HStack {
                            Text("Privacy & Policy")
                            
                            Spacer()
                            
                            
                            .frame(height: 44)
                            
                        }
                        Divider()
                            .background(Color.red)
                        HStack {
                            Text("Logout")
                            
                            Spacer()
                            
                            
                            .frame(height: 44)
                            
                        }
                        
                    }
                    
                }
                .listRowSeparator(.hidden)
                .listRowInsets(.none)
                
            }
            .listStyle(.plain)
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

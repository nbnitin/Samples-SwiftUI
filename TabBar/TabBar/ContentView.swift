//
//  ContentView.swift
//  TabBar
//
//  Created by Nitin Bhatia on 21/09/22.
//

//some limitations still apply.

//As you can see from the first section:

/*The header is limited to two-line (and .lineLimit won't help).
The footer is too large and starts to overlap the content.
These behaviors vary based on a list-style, so you should be mindful that the result might not match what you expected. */



import SwiftUI

struct ContentView: View {
    @Environment(\.presentationMode) var presentation
    var btnBack : some View { Button(action: {
            self.presentation.wrappedValue.dismiss()
            }) {
                HStack {
                Image("ic_back") // set image here
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    Text("Go back")
                }
            }
        }
   
    var body: some View {
        
                    List {
                        Section {
                            Text("About")
                            Text("Software Update")
                        } header: {
                            Text("Header Style 1")
                        } footer: {
                            Text("Footer Style 1")
                        }
                        .headerProminence(.increased) //using prominenece
                        //Using .headerProminence(.increased) has no effect on .inset list style.
                        Section {
                            Text("AirDrop")
                            Text("AirPlay & Handoff")
                            Text("Picture in Picture")
                            Text("CarPlay")
                        }header: {
                            Text("Header Style 2")
                                .font(.system(size: 36))
                        } footer: {
                            Text("Footer Style 2")
                        }
                        Section {
                            Text("iPhone Storage")
                            Button("Background App Refresh", action: {
                                print("hi")
                            }).foregroundColor(Color.black)
                            //Text("Background App Refresh")
                        } header: {
                            Text("Only Header")
                                .bold()

                                                        .foregroundColor(.pink)
                        }
                        Section {
                            NavigationLink(destination:ContentView()) {
                                Text("Date & Time")
                                    .onTapGesture {
                                        print("date & time clicked")
                                    }
                            }
                            Text("Keyboard")
                            Text("Fonts")
                            Text("Language & Region")
                        } footer: {
                            Text("Only Footer")
                                .font(.system(size: 36))
                        }
                    }
                    .scrollIndicators(.hidden)
                    .navigationTitle("General")
                    .navigationBarTitleDisplayMode(.inline)
                    
//                    .toolbar(content: {
//                        ToolbarItem(placement: .navigationBarLeading) {
//                            Button(action: {
//                                presentation.wrappedValue.dismiss()
//                            }) {
//                                Text("Back")
//                            }
//                        }
//                    })
                   
                    
        
                    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  AppUpdateInfo.swift
//  UpdateChecker
//
//  Created by Nitin Bhatia on 01/11/25.
//

import SwiftUI

struct AppUpdateInfo: View {
    var info: UpdateCheckerManager.ReturnResult
    var forceUpdate: Bool
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack(spacing: 15) {
            Image(.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay {
                    GeometryReader {
                        let size = $0.size
                        let actualImageSize = CGSize(width: 399, height: 727) //this is the size of image coming from assets adjust as per need
                        let ratio = min(size.width / actualImageSize.width, size.height / actualImageSize.height)
                        
                        let logoSize = CGSize(width: 100 * ratio, height: 100 * ratio)
                        let logoPlacement = CGSize(width: size.width * ratio + 18, height: size.height * ratio + 31)
                        
                        if let appLogo = URL(string: info.appLogo) {
                      
                            
                            AsyncImage(url: appLogo, content: {image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: logoSize.width, height: logoSize.height)
                                    .clipShape(.rect(cornerRadius: 30 * ratio))
                                    .offset(logoPlacement)
                                
                            }, placeholder: {ProgressView()})
                        }
                    }
                }
            VStack(spacing: 8) {
                Text("App Update Is Available")
                    .font(.title.bold())
                Text("There is an app update available. Please update to the latest version **\(info.availableVersion)**")
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
            }
            .padding(.horizontal, 20)
            .padding(.top, 15)
            .padding(.bottom, 5)
            
            VStack(spacing: 8) {
                if let appURL = URL(string: info.appURL) {
                    Button {
                        openURL(appURL)
                        if !forceUpdate {
                            dismiss()
                        }
                    } label: {
                        Text("Update Now")
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 4)
                    }
                    .buttonStyle(.glassProminent)
                    .buttonBorderShape(.capsule)
                    if !forceUpdate {
                        Button {
                            dismiss()
                        } label: {
                            Text("Later")
                                .fontWeight(.medium)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 4)
                        }
                    }
                }
            }
            
        }
        .fontDesign(.rounded)
        .padding(20)
        .padding(.bottom, isiOS26 ? 10: 0)
        .presentationDetents([.height(450)])
        .interactiveDismissDisabled(forceUpdate)
        .presentationBackground(.background)
        .ignoresSafeArea(.all, edges: isiOS26 ? .all : [])
        
    }
    
    var isiOS26: Bool {
        if #available(iOS 26, *) {
            return true
        }
        return false
    }
    
}

#Preview {
    ContentView()
}

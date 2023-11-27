//
//  StatusBarView.swift
//  ChangeStatusBarStyle
//
//  Created by Nitin Bhatia on 27/11/23.
//

import SwiftUI

struct StatusBarView<Content:View>: View {
   
    @ViewBuilder var content: Content
    //status bar view window
    @State private var statusBarWindow: UIWindow?
    
    var body: some View {
        content
            .onAppear(perform: {
                if statusBarWindow == nil {
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        let statusBarWindow = UIWindow(windowScene: windowScene)
                        statusBarWindow.windowLevel = .statusBar
                        statusBarWindow.tag = 0320
                        let controller = StatusBarController() //since it just a statusbar window so we don't need any interaction on that, So we are disabling the interaction on this.
                        controller.view.backgroundColor = .clear
                        controller.view.isUserInteractionEnabled = false
                        statusBarWindow.rootViewController = controller
                        statusBarWindow.isHidden = false
                        statusBarWindow.isUserInteractionEnabled = false
                        self.statusBarWindow = statusBarWindow
                    }
                }
            })
    }
}

extension UIApplication {
    func setStatusBarStyle(_ style: UIStatusBarStyle) {
        //with this tag we can identify our overlay window in our window scene
        if let statusBarWindow = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first(where: {$0.tag == 0320}), let statusBarController = statusBarWindow.rootViewController as? StatusBarController {
            //updating status bar style
            statusBarController.statusBarStyle = style
            //refering changes
            statusBarController.setNeedsStatusBarAppearanceUpdate()
        }
    }
}

class StatusBarController : UIViewController {
    var statusBarStyle: UIStatusBarStyle = .default
    
    override var  preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
}

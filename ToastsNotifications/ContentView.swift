//
//  ContentView.swift
//  ToastNotification
//
//  Created by Nitin Bhatia on 28/02/26.
//

import SwiftUI
struct ContentView: View {
    @State private var toasts: [Toast] = []
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button {
                toasts.append(Toast(type: .info, title: "Toast info", message: "Toast message"))
            } label: {
                Text("info")
            }
            
            Button("Success") {
                let newToast = Toast(
                    type: .success,
                    title: "Success!",
                    message: "This is a toast message"
                )
                toasts.append(newToast)
            }
            
            Button("Warning") {
                let newToast = Toast(
                    type: .warning,
                    title: "Warning!",
                    message: "This is a toast message"
                )
                toasts.append(newToast)
            }
            
            Button("Error") {
                let newToast = Toast(
                    type: .error,
                    title: "Error!",
                    message: "This is a toast message"
                )
                toasts.append(newToast)
            }
            
            Button("Actionable") {
                let newToast = Toast(
                    type: .success,
                    title: "Success!",
                    message: "This is a toast message",
                    actionView: ActionView(text: "Press Me"){
                        sayHello()
                    }
                )
                toasts.append(newToast)
            }
            
        }
        .toastView(toasts: $toasts)
        .alert("Triggered alert", isPresented: $showAlert, actions: {})
    }
    
    func sayHello() {
        showAlert.toggle()
    }
}

#Preview {
    ContentView()
}

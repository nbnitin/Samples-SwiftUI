//
//  ToastModifier.swift
//  ToastNotification
//
//  Created by Nitin Bhatia on 28/02/26.
//

import SwiftUI

public struct ToastModifier: ViewModifier {
    @Binding var toasts: [Toast]
    var position: ToastPosition = .bottom
    @State private var workItems: [UUID: DispatchWorkItem] = [:] // Track timers for each toast
    
    public func body(content: Content) -> some View {
        ZStack {
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Stack multiple toasts at the bottom
            VStack {
                if position == .bottom || position == .center {
                    Spacer()
                }
                
                ForEach(toasts) { toast in
                    ToastView(
                        type: toast.type,
                        title: toast.title,
                        message: toast.message,
                        actionView: toast.actionView
                    ) {
                        dismissToast(toast)
                    }
                    .transition(.move(edge: position == .bottom ? .bottom : .top).combined(with: .opacity))
                    .animation(.spring(), value: toasts)
                }
                if position == .top || position == .center {
                    Spacer()
                }
            }
            .padding(.bottom, 16)
        }
        .onChange(of: toasts) { _ in
            scheduleDismissals()
        }
    }
    
    // MARK: - Toast Timing
    private func scheduleDismissals() {
        for toast in toasts {
            guard toast.duration > 0, workItems[toast.id] == nil else { continue }
            
            let task = DispatchWorkItem { dismissToast(toast) }
            workItems[toast.id] = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
            
            // Haptic feedback only on new toast
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
    }
    
    private func dismissToast(_ toast: Toast) {
        withAnimation(.spring()) {
            toasts.removeAll { $0.id == toast.id }
        }
        
        // Cancel timer
        workItems[toast.id]?.cancel()
        workItems.removeValue(forKey: toast.id)
    }
}

// MARK: - View Extension
extension View {
    func toastView(toasts: Binding<[Toast]>, position: ToastPosition = .bottom) -> some View {
        self.modifier(ToastModifier(toasts: toasts, position: position))
    }
}

#Preview {
    ContentView()
}

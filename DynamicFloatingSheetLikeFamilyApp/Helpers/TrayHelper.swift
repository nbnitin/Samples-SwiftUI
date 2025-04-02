//
//  TrayHelper.swift
//  DynamicFloatSheetLikeFamilyApp
//
//  Created by Nitin Bhatia on 08/03/25.
//

import SwiftUI

struct TrayConfig {
    var maxDetent: PresentationDetent
    var conrenrRadius: CGFloat = 30
    var isInteractiveDismissedDisabled: Bool = false
    var horizontalPadding: CGFloat = 15
    var bottomPadding: CGFloat = 15
}

extension View {
    @ViewBuilder
    func systemTrayView<Content: View>(
        _ show: Binding<Bool>,
        config: TrayConfig = .init(maxDetent: .fraction(0.99)),
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self.sheet(isPresented: show) {
            content()
                .background(.background)
                .clipShape(.rect(cornerRadius: config.conrenrRadius))
                .padding(.horizontal, config.horizontalPadding)
                .padding(.bottom, config.bottomPadding)
                .frame(maxHeight: .infinity, alignment: .bottom)
            //presentation configuration
                .presentationDetents( [config.maxDetent] )
                .presentationCornerRadius(0)
                .presentationBackground(.clear)
                .presentationDragIndicator(.hidden)
                .interactiveDismissDisabled(config.isInteractiveDismissedDisabled)
                .background(RemoveSheetShadow())
        }
    }
}

fileprivate struct RemoveSheetShadow: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        
        DispatchQueue.main.async {
            if let shadowView = view.dropShadowView() {
                shadowView.layer.shadowColor = UIColor.clear.cgColor
            }
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        uiView.layer.shadowOpacity = 0
    }
}

extension UIView {
    public func dropShadowView() -> UIView? {
        if let superview, String(describing: type(of: superview)) == "UIDropShadowView" {
            return superview
        }
        return superview?.dropShadowView()
    }
}

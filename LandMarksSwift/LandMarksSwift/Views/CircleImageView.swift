//
//  CircleImageView.swift
//  PracticeSwiftUI
//
//  Created by Nitin Bhatia on 15/09/22.
//

import SwiftUI

struct CircleImageView: View {
    var img : Image
    var body: some View {
        
        img
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white,lineWidth: 4)
            }
            .shadow(radius: 7)

    }
}

struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView(img: Image(systemName: "globe"))
    }
}

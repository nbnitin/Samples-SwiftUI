//
//  RatingStars.swift
//  StarRatings
//
//  Created by Nitin Bhatia on 16/08/25.
//

import SwiftUI

struct RatingStars: View {
    @Binding var ratings: Int
    var totalStars: Int = 5
    var selectedColor: Color = .yellow
    var unSelectedColor: Color = .gray
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<totalStars, id: \.self) { index in
                Image(systemName: ratings >= index + 1 ? "star.fill" :"star")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .padding(16)
                    .id(index)
                    .foregroundStyle(ratings >= index + 1 ? selectedColor : unSelectedColor)
                    .onTapGesture {
                        setRating(index + 1)
                    }
            }
            
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    let starWidth: CGFloat = 40 // approx frame + padding per star
                    let newRating = Int((value.location.x / starWidth).rounded(.up))
                    if newRating >= 0 && newRating <= totalStars {
                        ratings = newRating
                    }
                }
        )
        
    }
    
    private func setRating(_ index: Int) {
        withAnimation(.spring(response: 0.3, dampingFraction: 1)) {
            if index == ratings {
                ratings -= 1
            } else {
                ratings = index
            }
        }
    }
}

#Preview {
    RatingStars(ratings: Binding.constant(0))
}

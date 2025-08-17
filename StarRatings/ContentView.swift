//
//  ContentView.swift
//  StarRatings
//
//  Created by Nitin Bhatia on 16/08/25.
//

import SwiftUI

struct ContentView: View {
    @State private var rating = 0
    @State private var totalStars: Double = 5
    @State private var showAlert = false
    @State private var selectedColor: Color = .red
    @State private var unSelectedColor: Color = .gray
    
    var body: some View {
        VStack {
            HStack {
                Text("Tap To Rate")
                RatingStars(ratings: $rating,totalStars: Int($totalStars.wrappedValue), selectedColor: $selectedColor.wrappedValue, unSelectedColor: $unSelectedColor.wrappedValue)
            }
            .padding()
            .onChange(of: rating, initial: false) { (oldValue, newValue) in
                print("Rating changed from \(oldValue) to \(newValue)")
            }
            
            HStack {
                Text("No. Of Ratings")
                Slider(value: $totalStars, in: 1...5, step: 1)
                    .onChange(of: totalStars) { oldValue, newValue in
                        rating = 0
                    }
            }
            Button("Get Ratings") {
                showAlert.toggle()
            }
            
            ColorPicker("Selected Color", selection: $selectedColor, )
            ColorPicker("Unselected Color", selection: $unSelectedColor)
        }
        .padding()
        .alert("Current Ratings", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("\(rating)/\(Int(totalStars))")
        }
    }
    
}

#Preview {
    ContentView()
}

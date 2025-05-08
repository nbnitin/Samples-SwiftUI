//
//  TaskCard.swift
//  TaskManagement
//
//  Created by Nitin Bhatia on 25/04/25.
//

import SwiftUI

struct TaskCard: View {
    var item: TasksModel?
    var isDeleted: (() -> Void)?
    var body: some View {
            VStack(alignment: .leading) {
                Text(item?.title ?? "")
                    .multilineTextAlignment(.leading)
                HStack {
                    Spacer()
                    Text(Date.now.formatted(date: .numeric, time: .omitted))
                        .multilineTextAlignment(.trailing)
                        .foregroundStyle(Color.black.opacity(0.6))
                }
                
            }
            .swipeActions(allowsFullSwipe: true){
                Button("Delete", action: {
                    isDeleted?()
                })
                .tint(Color.red)
            }
            .padding(10)
            .background(Color(red: 0.98, green: 0.89, blue: 0.46))
            .foregroundColor(Color(red: 0.18, green: 0.2, blue: 0.29))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .shadow(color:.black.opacity(0.5), radius: 5, x: 0, y: 5)
                }
    
}

#Preview {
    TaskCard() {
        
    }
}

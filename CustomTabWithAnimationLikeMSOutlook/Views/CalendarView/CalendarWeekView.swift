//
//  CalendarWeekView.swift
//  CustomToolBarInPlaceOfTabBarLikeOutlook
//
//  Created by Nitin Bhatia on 24/06/25.
//

import SwiftUI

struct CalendarWeekView: View {
    let date: Date
    private let calendar = Calendar.current
    @Binding var currentCalendarView: CalendarViewMode
    @Binding var isDraggable: Bool
    @State var selectedDate: Date = Date()
    @State var selectedDateColor: Color = .red
    var onDateSelected: ((Date) -> Void)? = nil
    
    private var weekDays: [Date] {
        guard let weekStart = calendar.dateInterval(of: .weekOfYear, for: date)?.start else { return [] }
        return (0..<7).compactMap {
           let rawDate = calendar.date(byAdding: .day, value: $0, to: weekStart)
            // 🔥 Set to noon to avoid timezone issues
            return calendar.date(bySettingHour: 12, minute: 0, second: 0, of: rawDate ?? Date())
        }
    }

    var body: some View {
        VStack {
            HStack(spacing: 8) {
                ForEach(weekDays, id: \.self) { date in
                    VStack {
                        Text(shortWeekday(for: date))
                            .font(.caption)
                            .foregroundColor(.gray)
                        Button(
                            action: {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                        selectedDate = date
                                    }
                                onDateSelected?(date)
                            },
                            label:{
                                Text("\(calendar.component(.day, from: date))")
                                    .frame(maxWidth: .infinity, minHeight: 40)
                                    .background(getBackgroundColorForSelectedDate(date))
                                    .cornerRadius(6)
                            }
                        )
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            if !isDraggable {
                Button(action: {
                    currentCalendarView = currentCalendarView == .month ? .week : .month
                }, label: {
                    Image(systemName: "chevron.down.circle")
                })
            }
           
        }
        .padding(.horizontal)
        .padding(.top, 8)
        .frame(maxHeight: .infinity, alignment: .top)
    }

    private func shortWeekday(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }
    
    func getBackgroundColorForSelectedDate(_ date: Date?) -> Color {
        guard let date else { return .clear }
        if calendar.isDateInToday(date) {
            return Color.red
        } else if calendar.isDate(date, inSameDayAs: selectedDate) {
            return Color.blue.opacity(0.3)
        }
        return Color.clear
    }
}

#Preview {
    CalendarView()
}

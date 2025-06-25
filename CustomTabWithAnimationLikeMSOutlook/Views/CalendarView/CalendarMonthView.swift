//
//  CalendarMonthView.swift
//  CustomToolBarInPlaceOfTabBarLikeOutlook
//
//  Created by Nitin Bhatia on 24/06/25.
//

import SwiftUI

struct CalendarMonthView: View {
    let date: Date
    private let calendar = Calendar.current
    @Binding var currentCalendarView: CalendarViewMode
    @Binding var isDraggable : Bool
    @State var selectedDate: Date = Date()
    @State var selectedDateColor: Color = .red
    var onDateSelected: ((Date) -> Void)? = nil
    
    private var days: [Date?] {
        guard let monthStart = calendar.date(from: calendar.dateComponents([.year, .month], from: date)),
              let range = calendar.range(of: .day, in: .month, for: date)
        else { return [] }

        let firstWeekday = calendar.component(.weekday, from: monthStart)
        let leading = Array(repeating: Optional<Date>.none, count: firstWeekday - 1)

        let dates = range.compactMap { day in
            if let rawDate = calendar.date(byAdding: .day, value: day - 1, to: monthStart) {
                // 🔥 Set to noon to avoid timezone issues
                return calendar.date(bySettingHour: 12, minute: 0, second: 0, of: rawDate)
            }
            return nil
        }

        return leading + dates
    }

    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible()), count: 7)
    }

    private var weekdaySymbols: [String] {
        // Start from Sunday
        calendar.shortStandaloneWeekdaySymbols
    }

    var body: some View {
        VStack(spacing: 8) {
            // Weekday Headers
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity)
                }
            }

            // Month Grid
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(days.indices, id: \.self) { index in
                    if let date = days[index] {
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
                    } else {
                        Color.clear.frame(height: 40)
                    }
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
        .padding(.top, 8)
        .padding(.horizontal)
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

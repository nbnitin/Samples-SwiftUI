import SwiftUI

enum CalendarViewMode: String, CaseIterable {
    case month = "Month"
    case week = "Week"
}


struct CalendarView: View {
   
    @State private var calendarViewMode: CalendarViewMode = .month
    @State private var currentPage = 1 // 0 = prev, 1 = current, 2 = next
    @State private var baseDate = Date()
    var onDateSelected: ((Date) -> Void)? = nil
    private let calendar = Calendar.current

    var body: some View {
        VStack {
            // Header
            HStack {
                Text(headerTitle(for: baseDate))
                    .font(.title2)
                    .fontWeight(.medium)
                Spacer()
                Picker("", selection: $calendarViewMode) {
                    ForEach(CalendarViewMode.allCases, id: \.self) {
                        Text($0.rawValue).tag($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 160)
            }
            .padding(.horizontal)

            // Horizontal Pager
            TabView(selection: $currentPage) {
                ForEach(0..<3) { index in
                    let offset = index - 1
                    if calendarViewMode == .month {
                        CalendarMonthView(date: calendar.date(byAdding: .month, value: offset, to: baseDate)!, currentCalendarView: $calendarViewMode, isDraggable: .constant(false), onDateSelected: onDateSelected)
                            .tag(index)
                            .frame(maxHeight: .infinity, alignment: .top)
                    } else {
                        CalendarWeekView(date: calendar.date(byAdding: .weekOfYear, value: offset, to: baseDate)!, currentCalendarView: $calendarViewMode, isDraggable: .constant(false), onDateSelected: onDateSelected)
                            .tag(index)
                        
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onChange(of: currentPage) { _, newValue in
                if newValue == 0 {
                    baseDate = calendarViewMode == .month
                        ? calendar.date(byAdding: .month, value: -1, to: baseDate)!
                        : calendar.date(byAdding: .weekOfYear, value: -1, to: baseDate)!
                } else if newValue == 2 {
                    baseDate = calendarViewMode == .month
                        ? calendar.date(byAdding: .month, value: 1, to: baseDate)!
                        : calendar.date(byAdding: .weekOfYear, value: 1, to: baseDate)!
                }
                currentPage = 1 // Reset to center after update
            }
            
        }
        .padding(.top)
    }

    private func headerTitle(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = calendarViewMode == .month ? "LLLL yyyy" : "'Week of' MMM d"
        return formatter.string(from: date)
    }
}

#Preview {
    CalendarView()
}

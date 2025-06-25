import SwiftUI

struct DraggableCalendarView: View {
    @State private var currentCalendarView: CalendarViewMode = .month
    @State private var dragOffset: CGFloat = 0
    @State private var baseDate = Date()
    @State private var currentPage = 1 // 0 = prev, 1 = current, 2 = next
    private let calendar = Calendar.current
    var onDateSelected: ((Date) -> Void)? = nil
    
    private var headerTitle: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLLL yyyy"
        return formatter.string(from: baseDate)
    }

    private var weekdaySymbols: [String] {
        calendar.shortStandaloneWeekdaySymbols
    }

    var body: some View {
        VStack(spacing: 0) {
            // Fixed Header
            HStack {
                Text(headerTitle)
                    .font(.title2)
                    .fontWeight(.medium)
                Spacer()
                Button(action: {
                    withAnimation {
                        toggleView()
                    }
                }) {
                    Image(systemName: currentCalendarView == .month ? "chevron.up.circle" : "chevron.down.circle")
                        .font(.title2)
                }
            }
            .padding(.horizontal)

            // Horizontal Pager
            TabView(selection: $currentPage) {
                ForEach(0..<3) { index in
                    let offset = index - 1
                    if currentCalendarView == .month {
                        CalendarMonthView(date: calendar.date(byAdding: .month, value: offset, to: baseDate)!, currentCalendarView: $currentCalendarView, isDraggable: .constant(true), onDateSelected: onDateSelected)
                            .tag(index)
                            .frame(maxHeight: .infinity, alignment:  .top)
                    } else {
                        CalendarWeekView(date: calendar.date(byAdding: .weekOfYear, value: offset, to: baseDate)!, currentCalendarView: $currentCalendarView, isDraggable: .constant(true), onDateSelected: onDateSelected)
                            .tag(index)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onChange(of: currentPage) { _, newValue in
                if newValue == 0 {
                    baseDate = currentCalendarView == .month
                        ? calendar.date(byAdding: .month, value: -1, to: baseDate)!
                        : calendar.date(byAdding: .weekOfYear, value: -1, to: baseDate)!
                } else if newValue == 2 {
                    baseDate = currentCalendarView == .month
                        ? calendar.date(byAdding: .month, value: 1, to: baseDate)!
                        : calendar.date(byAdding: .weekOfYear, value: 1, to: baseDate)!
                }
                currentPage = 1 // Reset to center after update
            }
            
            
        }
        RoundedRectangle(cornerRadius: 10)
            .fill(Color.red)
                .frame(height: 32, alignment: .top)
                .offset(y: dragOffset)
                .padding(.top, currentCalendarView == .month ? -50 : -250)
                .overlay {
                    Image(systemName: currentCalendarView == .month ? "chevron.up.circle" : "chevron.down.circle")
                        .font(.title2)
                        .padding(.top, currentCalendarView == .month ? -45 : -245)
                        .offset(y: dragOffset)
                }
                .frame(maxHeight: .infinity)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation.height
                            withAnimation {
                                if dragOffset > 70 {
                                    currentCalendarView = .month
                                } else if dragOffset < -50 {
                                    currentCalendarView = .week
                                }
                            }
                        }
                        .onEnded { value in
                            withAnimation {
                                if value.translation.height < -50 {
                                    currentCalendarView = .week
                                } else if value.translation.height > 50 {
                                    currentCalendarView = .month
                                }
                                dragOffset = 0
                            }
                        }
                )
        .padding(.top)
        .frame(maxHeight: .infinity, alignment: .top)
            
        
            
    }

    private func toggleView() {
        currentCalendarView = currentCalendarView == .month ? .week : .month
    }
}

#Preview {
    DraggableCalendarView()
//    ContentView()
}

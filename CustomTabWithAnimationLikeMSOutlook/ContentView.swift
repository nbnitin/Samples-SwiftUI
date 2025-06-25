import SwiftUI

enum Tab {
    case mail, calendar, search
}

struct ContentView: View {
    @State private var selectedTab: Tab = .mail
    @State private var isTabBarVisible = true
    @State private var isEditing = false
    @State private var selectedItems: Set<Int> = []
    @State private var data: [Int] = Array(1...20)
    
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                VStack(spacing: 0) {
                    // Main content
                    ZStack {
                        
                        MailView(isTabBarVisible: $isTabBarVisible, isEditing: $isEditing, selectedItems: $selectedItems, data: $data).opacity(selectedTab == .mail ? 1 : 0)
//                        DraggableCalendarView() {date in
//                            onDateSelected(date)
//                        }
                        CalendarView() {date in
                            onDateSelected(date)
                        }
                            .opacity(selectedTab == .calendar ? 1 : 0)
//                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        Text("Search View")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .opacity(selectedTab == .search ? 1 : 0)
                    }
                    
                    // Custom Tab Bar
                    if isTabBarVisible {
                        CustomTabBar(selectedTab: $selectedTab)
                    }
                }
                .navigationTitle(navigationTitle)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    if !isEditing {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button(action: {}) {
                                Image(systemName: "line.3.horizontal")
                            }
                        }
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button(action: {
                                withAnimation {
                                    isEditing = true
                                    isTabBarVisible = false
                                }
                            }) {
                                Image(systemName: "square.and.pencil")
                            }
                        }
                    }
                }
                
                if isEditing {
                    CustomToolBar(isEditing: $isEditing, isTabBarVisible: $isTabBarVisible, data: $data, selectedItems: $selectedItems)
                }
            }
        }
    }
    
    private var navigationTitle: String {
        switch selectedTab {
        case .mail:
            return "Mail"
        case .calendar:
            return "Calendar"
        case .search:
            return "Search"
        }
    }
    
    func onDateSelected(_ date: Date) {
        print("Selected Date: \(date)")
    }
}

// MARK: - Preview

#Preview {
    ContentView()
}

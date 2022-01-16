//
//  CalendatView.swift
//  MySecretary
//
//  Created by jang gukjin on 2022/01/14.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey{
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

struct ScrollViewOffsetPreferenceKey: PreferenceKey{
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

struct CalendarView: View {
    
    // MARK: Property
    let tabBarImangeNames = ["app.badge", "scroll", "plus.circle.fill", "hands.clap", "gearshape"]
    @State private var scrollHeight: Double = 0.0
    @State private var heigtCalendar : CGFloat = 0
    @State private var currentMonth: Int = 0
    @State private var isExpand: Bool = false
    @Binding var currentDate: Date
    let days: [String] = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    let deviceHeight: CGFloat = UIScreen.main.bounds.height
    
    // MARK: View
    var body: some View {
        ZStack {
            GeometryReader{ geometryReader in
                VStack(spacing: 0) {
                    VStack {
                        Spacer().frame(height: UIDevice.current.hasNotch ? 120 : 80)
                        
                        daysOfTheWeek()
                        
                        Spacer().frame(height: 10)
                        
                        daysGrid()
                    }
                    .background(
                        GeometryReader{ proxy in
                            let offset = proxy.frame(in: .named("scroll")).minY
                            Color.clear.preference(key: SizePreferenceKey.self, value: proxy.size)
                            Color.clear.preference(key: ScrollViewOffsetPreferenceKey.self, value: offset)
                        }
                    )
                    
                    Spacer()
                }
                .background(Color(UIColor.systemBackground))
                .onChange(of: currentMonth, perform: { newValue in
                    currentDate = getCurrentMonth()
                })
                .onPreferenceChange(SizePreferenceKey.self) { newSize in
                    self.heigtCalendar = newSize.height
                }
                .onPreferenceChange(ScrollViewOffsetPreferenceKey.self) { value in
                    print("스크롤: \(scrollHeight - ((deviceHeight * 0.75) + 433))")
                    self.scrollHeight = value
                }
            }
            
            TaskView(isExpand: $isExpand, maxHeight: deviceHeight - (UIDevice.current.hasNotch ? 140 : 100), minHeight: deviceHeight - heigtCalendar - (UIDevice.current.hasNotch ? 120 : 90), tasks: tasks, currentDate: currentDate)
                .shadow(color: .primary.opacity(0.3), radius: 10, x: 10, y: 10)
                .shadow(color: .gray.opacity(0.12), radius: 10, x: -5, y: -5)
            
            
            VStack(spacing: 0) {
                Color(UIColor.systemBackground).frame(height: UIDevice.current.hasNotch ? 50 : 10)
                
                yearAndMonth()
                    .background(Color(UIColor.systemBackground))
                    .frame(height: 50)
                
                Spacer()
            }
        }
        
    }
}

// MARK: Extension
extension CalendarView {
    // MARK: View
    /// 연도와 월
    @ViewBuilder
    func yearAndMonth() -> some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 5) {
                Text(extraDate()[0])
                    .font(.caption)
                    .fontWeight(.semibold)
                
                Text(extraDate()[1])
                    .font(.title.bold())
                    .foregroundColor(.pink)
            }
            
            Spacer(minLength: 0)
            
            Button(action: {
                withAnimation(Animation.easeInOut(duration: 0.12)){
                    currentMonth -= 1
                }
            }, label: {
                Image(systemName: "chevron.left").font(.title2)
                    .foregroundColor(.primary)
            }).opacity(isExpand ? 0 : 1).disabled(isExpand ? true : false)
            
            Button(action: {
                withAnimation(Animation.easeInOut(duration: 0.12)) {
                    currentMonth += 1
                }
            }, label: {
                Image(systemName: "chevron.right").font(.title2)
                    .foregroundColor(.primary)
            }).opacity(isExpand ? 0 : 1).disabled(isExpand ? true : false)
        }
        .padding([.leading, .trailing], 20)
    }
    
    /// 요일들
    @ViewBuilder
    func daysOfTheWeek() -> some View {
        HStack(spacing: 0) {
            ForEach(days, id: \.self) { day in
                Text(day)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.primary)
            }
        }
        .padding([.leading, .trailing], 10)
    }
    
    /// 해당 월의 일수들
    @ViewBuilder
    func daysGrid() -> some View {
        LazyVGrid(columns: columns, spacing: 5) {
            ForEach(extractDate()) { value in
                CardView(value: value)
                    .background(
                        Circle()
                            .fill(.pink)
                            .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                            .frame(width: 50, height: 50, alignment: .center)
                    )
                    .onTapGesture {
                        currentDate = value.date
                    }
            }
        }
        .padding([.leading, .trailing], 10)
    }
    
    /// 달력 안에 일들을 나타낸 View
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        VStack {
            if value.day != -1 {
                if let task = tasks.first(where: { task in
                    return isSameDay(date1: task.taskDate, date2: value.date)
                }) {
                    Text("\(value.day)")
                        .font(.body.bold())
                        .foregroundColor(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    Circle()
                        .fill(isSameDay(date1: task.taskDate, date2: currentDate) ? .white : .pink)
                        .frame(width: 8, height: 8)
                } else {
                    Text("\(value.day)")
                        .font(.body.bold())
                        .foregroundColor(isSameDay(date1: value.date, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                }
            }
        }
        .padding([.top, .bottom], 6)
        .frame(height: 50)
    }
    
    // MARK: Custom Method
    /// 연도[0]와 월[1]을 가져옵니다.
    func extraDate() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    /// 현재 월을 가져옵니다.
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }

        return currentMonth
    }
    
    /// 해당 월에 대한 일들을 가져옵니다.
    func extractDate() -> [DateValue]{
        let calendar = Calendar.current
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
}

// MARK: Preview
struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(currentDate: .constant(Date()))
    }
}

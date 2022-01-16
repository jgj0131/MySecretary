//
//  ContentView.swift
//  Shared
//
//  Created by jang gukjin on 2021/03/10.
//

import SwiftUI
import CoreData

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct ContentView: View {
    
    var body: some View {
        #if os(iOS)
        if UIDevice.current.userInterfaceIdiom == .phone {
            TabBarView().background(Color(UIColor.systemBackground))
        } else {
            SideBarView().background(Color(UIColor.systemBackground))
        }
        #else
        SideBarView().background(Color(UIColor.systemBackground))
        #endif
    }
}

// MARK: Extension
// 노치가 있는 아이폰과 없는 아이폰 구분용
extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")

    var hasNotch: Bool {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let bottom = windowScene?.windows.first?.safeAreaInsets.bottom ?? 0
        
        return bottom > 0
    }
}

extension View {
    /// 특정부분만 radius를 줍니다.
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    
    /// 두날짜가 같은지 비교합니다.
    func isSameDay(date1: Date, date2: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
}

extension Date {
    /// 해당 월의 날짜들을 가져옵니다.
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, . month], from: self))!
        let range = calendar.range(of: .day, in: .month, for: self)!
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}


// MARK: Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        #if os(iOS)
        Group {
            ContentView().previewDevice("iPad Pro (12.9-inch) (4th generation)")
            ContentView().previewDevice("iPhone 12 Pro")
//            ContentView().previewDevice("Apple Watch Series 6 - 44mm")
        }
        #else
        ContentView().previewDevice("Mac")
        #endif
    }
}

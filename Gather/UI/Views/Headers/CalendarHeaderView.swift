//
//  CalendarHeaderView.swift
//  Gather
//
//  Created by Tyler Cagle on 10/14/20.
//

import SwiftUI

struct CalendarHeaderView: View {
    var dates: [Date] {
        let today = Date()
        var week: [Date] = []
        var mutableDate = today
        for _ in 0..<3 {
            mutableDate = mutableDate.dayBefore
            week.append(mutableDate)
        }
        week.append(today)
        mutableDate = today
        for _ in 0..<3 {
            mutableDate = mutableDate.dayAfter
            week.append(mutableDate)
        }
        return week
    }

    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "E d"
        return formatter
    }

    private func createDateLabels(date: Date) -> [String] {
        let dateString = dateFormatter.string(from: date)
        let components = dateString.components(separatedBy: " ")
        return components
    }

    var body: some View {
        HStack(spacing: 0) {
            ForEach(dates, id: \.timeIntervalSince1970) { date in
                let dateLabels = createDateLabels(date: date)
                VStack {
                    Text(dateLabels.first ?? "")
                        .customFont(Calendar.current.isDateInToday(date) ? .heavy : .medium, category: .medium)
                        .foregroundColor(Colors.backgroundInvert)
                        .opacity(Calendar.current.isDateInToday(date) ? 1 : 0.4)

                    Text(dateLabels.last ?? "")
                        .customFont(Calendar.current.isDateInToday(date) ? .heavy : .medium, category: .medium)
                        .foregroundColor(Colors.backgroundInvert)
                        .opacity(Calendar.current.isDateInToday(date) ? 1 : 0.4)
                }
                if date != dates.last {
                    Spacer()
                }
            }
        }
            .padding(.horizontal, Sizes.Small)
    }
}

struct CalendarHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarHeaderView()
    }
}

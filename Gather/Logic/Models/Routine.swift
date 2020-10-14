//
//  Routine.swift
//  Gather
//
//  Created by Tyler Cagle on 10/8/20.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Routine: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var startTime: Date
    var endTime: Date
    var color: String
    @ServerTimestamp var createdTime: Timestamp?
    @ServerTimestamp var updatedTime = Timestamp.init(date: Date())
    var userId: String?

    var useableColor: Color {
        let color = Color(self.color)
        return color
    }
}

/// This is a helper function to quickly create dates so that this code will work. You probably don't need this in your code.
func constructDate(day: Int = 1, month: Int = 1, year: Int = 2020, hour: Int, minute: Int) -> Date {
    var dateComponents = DateComponents()
    dateComponents.year = year
    dateComponents.month = month
    dateComponents.day = day
    dateComponents.timeZone = TimeZone.current
    dateComponents.hour = hour
    dateComponents.minute = minute

    // Create date from components
    let userCalendar = Calendar.current // user calendar
    let someDateTime = userCalendar.date(from: dateComponents)
    return someDateTime!
}

#if DEBUG
var testDataRoutines: [Routine] = [
    Routine(title: "Morning routine", startTime: constructDate(hour: 7, minute: 0), endTime: constructDate(hour: 9, minute: 0), color: "orange"),
    Routine(title: "Early work", startTime: constructDate(hour: 9, minute: 0), endTime: constructDate(hour: 13, minute: 0), color: "blue"),
    Routine(title: "Midday break", startTime: constructDate(hour: 13, minute: 0), endTime: constructDate(hour: 13, minute: 30), color: "green"),
    Routine(title: "Late work", startTime: constructDate(hour: 13, minute: 30), endTime: constructDate(hour: 17, minute: 0), color: "blue"),
    Routine(title: "Evening routine", startTime: constructDate(hour: 17, minute: 0), endTime: constructDate(hour: 22, minute: 0), color: "orange")
]
#endif


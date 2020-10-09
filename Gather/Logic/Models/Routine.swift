//
//  Routine.swift
//  Gather
//
//  Created by Tyler Cagle on 10/8/20.
//

import SwiftUI

struct Routine: Identifiable {
    let id = UUID()
    
    let title: String
    let start: Date
    let duration: Double
    let color: Color
    
    /// This is a helper function to quickly create dates so that this code will work. You probably don't need this in your code.
    static func constructDate(day: Int = 1, month: Int = 1, year: Int = 2020, hour: Int, minute: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.timeZone = TimeZone(abbreviation: "GMT")
        dateComponents.hour = hour
        dateComponents.minute = minute

        // Create date from components
        let userCalendar = Calendar.current // user calendar
        let someDateTime = userCalendar.date(from: dateComponents)
        return someDateTime!
    }
}

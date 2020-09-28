//
//  Task.swift
//  Gather
//
//  Created by Tyler Cagle on 9/28/20.
//

import SwiftUI

enum TaskPriority: Int, Codable {
    case high
    case medium
    case low
}

struct Task: Identifiable, Codable {
    var id: String = UUID().uuidString
    var title: String
    var priority: TaskPriority
    var completed: Bool
}

#if DEBUG
let testDataTasts = [
    Task(title: "Implement UI", priority: .medium, completed: false),
    Task(title: "Connect to Firebase", priority: .medium, completed: false),
    Task(title: "Walk the dog", priority: .high, completed: false),
    Task(title: "Profit!!", priority: .high, completed: false)
]
#endif

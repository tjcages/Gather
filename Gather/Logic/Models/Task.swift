//
//  Task.swift
//  Gather
//
//  Created by Tyler Cagle on 9/28/20.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

enum TaskPriority: Int, Codable {
    case high
    case medium
    case low
}

struct Task: Identifiable, Codable {
    @DocumentID var id: String?
    var title: String
    var priority: TaskPriority
    var completed: Bool
    var routineId: String
    @ServerTimestamp var createdTime: Timestamp?
    @ServerTimestamp var updatedTime = Timestamp.init(date: Date())
    var userId: String?
}

#if DEBUG
let testDataTasts = [
    Task(title: "Implement UI", priority: .medium, completed: false, routineId: ""),
    Task(title: "Connect to Firebase", priority: .medium, completed: false, routineId: ""),
    Task(title: "Walk the dog", priority: .high, completed: false, routineId: ""),
    Task(title: "Profit!!", priority: .high, completed: false, routineId: "")
]
#endif

//
//  TestDataTaskRepository.swift
//  Gather
//
//  Created by Tyler Cagle on 9/28/20.
//

import Foundation

class TestDataTaskRepository: BaseTaskRepository, TaskRepository, ObservableObject {
    override init() {
        super.init()
        self.tasks = testDataTasts
    }

    func addTask(_ task: Task) {
        tasks.append(task)
    }

    func removeTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
        }
    }
    
    func updateTask(_ task: Task) {
        if let index = self.tasks.firstIndex(where: { $0.id == task.id }) {
            self.tasks[index] = task
        }
    }
}

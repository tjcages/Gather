//
//  TaskRepository.swift
//  Gather
//
//  Created by Tyler Cagle on 9/28/20.
//

import Foundation
import Disk

class LocalTaskRepository: BaseTaskRepository, TaskRepository, ObservableObject {
    override init() {
        super.init()
        loadData()
    }
    
    func addTask(_ task: Task) {
        self.tasks.append(task)
        saveData()
    }
    
    func removeTask(_ task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
            saveData()
        }
    }
    
    func updateTask(_ task: Task) {
        if let index = self.tasks.firstIndex(where: { $0.id == task.id }) {
            self.tasks[index] = task
            saveData()
        }
    }
    
    private func loadData() {
        if let retrievedTasks = try? Disk.retrieve("tasks.json", from: .documents, as: [Task].self) {
            self.tasks = retrievedTasks
        }
    }
    
    private func saveData() {
        do {
            try Disk.save(self.tasks, to: .documents, as: "tasks.json")
        }
        catch let error as NSError {
            fatalError("""
                Domain: \(error.domain)
                Code: \(error.code)
                Description: \(error.localizedDescription)
                Failure Reason: \(error.localizedFailureReason ?? "")
                Suggestions
            """)
        }
    }
}

//
//  TaskListView.swift
//  Gather
//
//  Created by Tyler Cagle on 9/28/20.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListVM: TaskListViewModel
    @State var routineId: String

    var tasks: [TaskCellViewModel] {
        var tasks: [TaskCellViewModel] = []
        for taskCellVM in taskListVM.taskCellViewModels {
            if taskCellVM.task.routineId == routineId {
                tasks.append(taskCellVM)
            }
        }
        return tasks
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Sizes.xSmall) {
            ForEach(tasks) { taskCellVM in
                TaskCell(taskCellVM: taskCellVM)
            }
                .onDelete { indexSet in
                    self.taskListVM.removeTasks(atOffsets: indexSet)
            }
        }
    }
}

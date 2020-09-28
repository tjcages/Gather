//
//  TaskListView.swift
//  Gather
//
//  Created by Tyler Cagle on 9/28/20.
//

import SwiftUI

struct TaskListView: View {
    @ObservedObject var taskListVM = TaskListViewModel()
    @State var presentAddNewItem = false

    var body: some View {
        VStack(alignment: .leading) {
            List {
                ForEach(taskListVM.taskCellViewModels) { taskCellVM in
                    TaskCell(taskCellVM: taskCellVM)
                }
                    .onDelete { indexSet in
                        self.taskListVM.removeTasks(atOffsets: indexSet)
                }

                if presentAddNewItem {
                    TaskCell(taskCellVM: TaskCellViewModel.newTask()) { result in
                        if case .success(let task) = result {
                            self.taskListVM.addTask(task: task)
                        }
                        self.presentAddNewItem.toggle()
                    }
                }
            }
            Button(action: { self.presentAddNewItem.toggle() }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)

                    Text("New task")
                }
            }
                .padding()
                .accentColor(.red)
        }
    }
}

struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView()
    }
}

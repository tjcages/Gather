//
//  StructureView.swift
//  Gather
//
//  Created by Tyler Cagle on 9/29/20.
//

import SwiftUI

struct RoutineView: View {
    @ObservedObject var taskListVM: TaskListViewModel
    @ObservedObject var routineListVM: RoutineListViewModel
    
    // This is where a user will be able to tap to add another task
    var body: some View {
        VStack(alignment: .leading, spacing: Sizes.xSmall) {
            ForEach(routineListVM.routineCellViewModels) { routineCellVM in
                RoutineCell(routineCellVM: routineCellVM)

                TaskListView(taskListVM: taskListVM, routineId: routineCellVM.routine.id ?? "")
                    .padding(.bottom, Sizes.Default)
            }
        }
            .padding(.bottom, Sizes.Big)
    }
}

//
//  ContentView.swift
//  Gather
//
//  Created by Tyler Cagle on 9/27/20.
//

import SwiftUI

enum ActiveSheet {
    case first
    case second
    case third
}

struct ContentView: View {
    @ObservedObject var taskListVM = TaskListViewModel()
    @ObservedObject var routineListVM = RoutineListViewModel()

//    @State var showSettingsScreen = false
//    @State var activeSheet: ActiveSheet = .first
    @State var presentAddNewItem = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                Colors.background

                VStack(spacing: 0) {
                    ContentHeaderView()

                    // Main feed for posts
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading, spacing: Sizes.Spacer) {
                            GreetingView()

                            RoutineView(taskListVM: taskListVM, routineListVM: routineListVM)
                        }
                    }
                        .offset(x: 0, y: 0)
                        .background(Color.clear)
                }

                // Bottom stack for buttons
                VStack {
                    Spacer()

                    HStack(alignment: .top) {
                        Spacer()

                        AddTaskButton(addTask: $presentAddNewItem)
                    }
                        .padding(.horizontal, Sizes.Default)
                }

                // Add a new cell to the list and publish to Firestore
                if presentAddNewItem {
                    NewItemView(taskCellVM: TaskCellViewModel.newTask(), routineListVM: routineListVM, presenting: $presentAddNewItem) { result in
                        if case .success(let task) = result {
                            self.taskListVM.addTask(task: task)
                            self.presentAddNewItem.toggle()
                        }
                    }
                }
            }
                .hideNavigationBar()
        }
//        .onAppear {
//            delayWithSeconds(3) {
//                for routine in testDataRoutines {
//                    self.routineListVM.addRoutine(routine: routine)
//                }
//            }
//        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

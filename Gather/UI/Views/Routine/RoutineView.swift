//
//  StructureView.swift
//  Gather
//
//  Created by Tyler Cagle on 9/29/20.
//

import SwiftUI

struct RoutineView: View {
    var routines: [Routine] = [
        Routine(title: "Morning routine", start: Routine.constructDate(hour: 6, minute: 30), duration: 2, color: Colors.orange),
        Routine(title: "Morning catch up", start: Routine.constructDate(hour: 8, minute: 30), duration: 0.5, color: Colors.green),
        Routine(title: "Deep work", start: Routine.constructDate(hour: 9, minute: 0), duration: 3, color: Colors.blue)
    ]
    
    // This is where a user will be able to tap to add another task
    var body: some View {
        VStack(alignment: .leading, spacing: Sizes.xSmall) {
            ForEach(routines) { routine in
                RoutineCell(routine: routine)

                TaskListView()
                    .padding(.bottom, Sizes.Default)
            }
        }
            .padding(.bottom, Sizes.Big)
    }
}

struct StructureView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineView()
    }
}

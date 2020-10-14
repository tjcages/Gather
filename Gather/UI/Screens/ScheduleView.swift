//
//  ScheduleItemView.swift
//  Gather
//
//  Created by Tyler Cagle on 10/8/20.
//

import SwiftUI

struct ScheduleView: View {
    @ObservedObject var routineListVM: RoutineListViewModel

    @State var selectedDate = Date()

    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        return formatter
    }
    
    var images: [String] = ["sunrise", "tray", "sun.max", "tray.full", "sunset", "moon"] // JUST FOR TESTING PURPOSES
    
    var routines: [RoutineCellViewModel] {
        var routines: [RoutineCellViewModel] = []
        if Calendar.current.isDateInToday(selectedDate) {
            for routineCellVM in routineListVM.routineCellViewModels {
                let endTime = routineCellVM.routine.endTime.time
                let currentTime = Date()
                if endTime > currentTime.time {
                    routines.append(routineCellVM)
                }
            }
        } else {
            routines = routineListVM.routineCellViewModels
        }
        return routines
    }

    var body: some View {
        VStack(alignment: .leading, spacing: Sizes.xSmall) {
            CalendarView(selectedDate: $selectedDate)
                .frame(width: UIScreen.main.bounds.width - Sizes.Small * 2, height: 400)
                .padding(.top, Sizes.xSmall)

            ForEach(Array(zip(routines, images)), id: \.0.id) { item in
                HStack {
                    Image(systemName: item.1)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: Sizes.Default, height: Sizes.Default)
                        .foregroundColor(Color(item.0.routine.color))

                    Text(item.0.routine.title)
                        .customFont(.heavy, category: .medium)
                        .foregroundColor(Colors.headline)
                        .padding(.leading, Sizes.Spacer / 2)

                    Spacer()

                    Text("\(item.0.routine.endTime, formatter: timeFormatter)")
                        .customFont(.medium, category: .small)
                        .foregroundColor(Colors.subheadline)
                }
                    .padding(.bottom, Sizes.Spacer)
            }
            
            HStack {
                Image(systemName: "plus.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Sizes.Default, height: Sizes.Default)
                    .foregroundColor(Colors.subheadline)

                Text("Set specific time")
                    .customFont(.heavy, category: .medium)
                    .foregroundColor(Colors.subheadline)
                    .padding(.leading, Sizes.Spacer / 2)
                
                Spacer()
            }
                .padding(.bottom, Sizes.Spacer)


            Spacer()
                .frame(height: Sizes.Large)
        }
            .padding(.top, Sizes.xSmall)
            .padding(.horizontal, Sizes.Small)
            .background(
                Colors.cellBackground
                    .cornerRadius(Sizes.Spacer)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                }
            )
    }
}

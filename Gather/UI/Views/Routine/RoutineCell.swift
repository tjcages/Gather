//
//  StructureCell.swift
//  Gather
//
//  Created by Tyler Cagle on 9/29/20.
//

import SwiftUI

struct RoutineCell: View {
    @State var routineCellVM: RoutineCellViewModel
    
    var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        return formatter
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: Sizes.Spacer) {
            HStack(alignment: .center, spacing: 0) {
                Text(routineCellVM.routine.title)
                    .customFont(.heavy, category: .medium)
                    .foregroundColor(routineCellVM.routine.useableColor)
                    .padding(.horizontal, Sizes.Default)
                    .fixedSize(horizontal: true, vertical: false)
                
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(routineCellVM.routine.useableColor)
            }
            Text("\(routineCellVM.routine.startTime, formatter: timeFormatter)")
                .customFont(.medium, category: .medium)
                .foregroundColor(Colors.subheadline)
                .padding(.horizontal, Sizes.Default)
        }
    }
}

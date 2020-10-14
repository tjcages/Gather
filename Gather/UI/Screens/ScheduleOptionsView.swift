//
//  ScheduleOptionsView.swift
//  Gather
//
//  Created by Tyler Cagle on 9/30/20.
//

import SwiftUI

enum ScheduleOptions: String {
    case schedule = "calendar"
    case duration = "timer"
}

struct ScheduleOptionsView: View {
    @State var task: ScheduleOptions
    @State var title: String
    @State var scheduleColor: Color
    @Binding var itemSelected: ScheduleOptions {
        didSet {
            if itemSelected == task {
                expanded.toggle()

                delayWithSeconds(Animation.animationIn) {
                    withAnimation(Animation.easeInOut(duration: Animation.animationQuick)) {
                        self.expanded.toggle()
                    }
                }
            }
        }
    }
    
    var buttonPressed: () -> () = { }

    @State var expanded = false

    var body: some View {
        let size = Sizes.xSmall

        HStack(alignment: .center, spacing: Sizes.Spacer / 2) {
            Image(systemName: task.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size, height: size)
                .foregroundColor(scheduleColor)
                .padding(.trailing, Sizes.Spacer)

            Text(title)
                .customFont(.heavy, category: .small)
                .foregroundColor(scheduleColor)
                .fixedSize()
        }
            .padding(.all, Sizes.Spacer)
            .padding(.horizontal, Sizes.Spacer / 2)
            .contentShape(Rectangle())
            .overlay(
                RoundedRectangle(cornerRadius: Sizes.Spacer)
                    .stroke(scheduleColor, lineWidth: 1.5)
            )
            .scaleEffect(expanded ? 1.1 : 1.0)
            .onTapGesture {
                buttonPressed()
                withAnimation(Animation.easeInOut(duration: Animation.animationQuick)) {
                    self.itemSelected = self.task
                }
        }
    }
}

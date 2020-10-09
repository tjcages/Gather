//
//  DefaultItemView.swift
//  Gather
//
//  Created by Tyler Cagle on 10/9/20.
//

import SwiftUI

struct DefaultItemView: View {
    @ObservedObject var taskCellVM: TaskCellViewModel

    @State var taskSelection: TaskItems = .task

    @State private var addDescription = false
    @State private var showReturnDescription = true

    @State private var descriptionFieldText = ""
    @State private var emojiIcon = ""

    @State private var titleFirstResponder = false
    @State private var descriptionFirstResponder = false

    @State var scheduleSelection: ScheduleOptions = .schedule

    var onCommit: (Result<Task, InputError>) -> Void = { _ in }
    var schedulePressed: () -> () = { }
    var durationPressed: () -> () = { }

    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                AddNewView(selection: $taskSelection)
                    .padding(.vertical, Sizes.xSmall)

                Spacer()

                SendButton {
                    if !self.taskCellVM.task.title.isEmpty {
                        self.onCommit(.success(self.taskCellVM.task))
                    } else {
                        self.onCommit(.failure(.empty))
                    }
                }
                //oncommit
            }
                .padding(.leading, Sizes.xSmall)
                .offset(y: Sizes.Spacer)

            VStack(alignment: .leading, spacing: 0) {
                // Add an icon
                IconView(emojiIcon: $emojiIcon)
                    .padding(.top, Sizes.Spacer)

                // Title textfield
                PlaceholderTextField(placeholder: Text(placeholder()), font: .heavy, size: .large, tag: 0, becomeFirstResponder: $titleFirstResponder, text: $taskCellVM.task.title, commit: {
                        if !taskCellVM.task.title.isEmpty {
                            withAnimation(Animation.easeInOut(duration: Animation.animationIn)) {
                                self.addDescription = true
                                self.showReturnDescription = false
                                self.descriptionFirstResponder = true
                            }
                        }
                    }, ended: {

                    }
                )

                // Description placeholder
                if descriptionFieldText.isEmpty && !taskCellVM.task.title.isEmpty && showReturnDescription {
                    Text("Press return to add a description")
                        .customFont(.medium, category: .medium)
                        .foregroundColor(Colors.subheadline)
                        .padding(.bottom, Sizes.Spacer)
                        .onTapGesture {
                            withAnimation(Animation.easeInOut(duration: Animation.animationIn)) {
                                self.addDescription = true
                                self.showReturnDescription = false
                                self.descriptionFirstResponder = true
                            }
                        }
                        .onAppear {
                            delayWithSeconds(4) {
                                withAnimation(Animation.easeInOut(duration: Animation.animationIn)) {
                                    self.showReturnDescription = false
                                }
                            }
                    }
                }

                if addDescription {
                    PlaceholderTextField(placeholder: Text("Add description"), font: .regular, size: .medium, tag: 1, becomeFirstResponder: $descriptionFirstResponder, text: $descriptionFieldText, commit: {
                            if descriptionFieldText.isEmpty {
                                addDescription = false
                            }
                        }, ended: {
                            if descriptionFieldText.isEmpty {
                                DispatchQueue.main.async {
                                    self.addDescription = false
                                }
                            }
                        }
                    )
                        .offset(x: 0, y: -Sizes.Spacer)
                }

                HStack(spacing: Sizes.xSmall) {
                    ScheduleOptionsView(task: .schedule, title: "Today", scheduleColor: Colors.green, itemSelected: $scheduleSelection) {
                        schedulePressed()
                    }

                    ScheduleOptionsView(task: .duration, title: "5-10 minutes", scheduleColor: Colors.blue, itemSelected: $scheduleSelection) {
                        durationPressed()
                    }
                }
                    .padding(.top, Sizes.Spacer)

                Spacer()
                    .frame(height: Sizes.Big)
            }
                .padding(.top, Sizes.xSmall)
                .padding(.horizontal, Sizes.Default)
                .background(
                    Colors.cellBackground
                        .cornerRadius(Sizes.Spacer)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                    }
                )
                .onAppear {
                    //                titleFirstResponder = true
            }
        }
    }

    func placeholder() -> String {
        var placeholder = "Enter task title"
        if taskSelection == .event {
            placeholder = "Enter event information"
        } else if taskSelection == .project {
            placeholder = "Enter project details"
        }
        return placeholder
    }
}

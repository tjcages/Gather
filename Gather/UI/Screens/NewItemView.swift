//
//  NewItemView.swift
//  Gather
//
//  Created by Tyler Cagle on 9/29/20.
//

import SwiftUI
import Introspect

struct NewItemView: View {
    @ObservedObject var taskCellVM: TaskCellViewModel
    @Binding var presenting: Bool
    @State private var showing: Bool = false

    var onCommit: (Result<Task, InputError>) -> Void = { _ in }

    var offset: CGFloat = 0

    @GestureState private var translation: CGFloat = 0
    @State private var snapRatio: CGFloat = 0.3

    @State private var showSchedule: Bool = false

    //MARK: -UI Logic

    var body: some View {
        VStack {
            Spacer()

            VStack(alignment: .leading, spacing: 0) {
                if !showSchedule {
                    DefaultItemView(taskCellVM: taskCellVM) { result in
                        onCommit(result)
                    } schedulePressed: {
                        // Schedule pressed
                        withAnimation() {
                            self.showSchedule.toggle()
                        }
                    } durationPressed: {
                        // Duration pressed
                    }
                } else {
                    ScheduleItemView()
                }
            }
                .offset(y: showing ? max(self.offset + self.translation, 0) : 364)
                .animation(.interactiveSpring())
                .gesture(
                    DragGesture()
                        .updating(self.$translation) { value, state, _ in
                            state = value.translation.height
                        }
                        .onEnded { value in

                    }
                )
        }
            .edgesIgnoringSafeArea(.bottom)
            .background(
                Colors.black
                    .opacity(showing ? 0.4 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        dismiss()
                }
            )
            .onAppear {
                showDisplay()
        }
    }

    func showDisplay() {
        withAnimation(Animation.easeInOut(duration: Animation.animationIn)) {
            self.showing.toggle()
        }
    }

    func dismiss() {
        let duration = Animation.animationIn
        UIApplication.shared.endEditing()
        withAnimation(Animation.easeInOut(duration: duration)) {
            self.showing.toggle()
            delayWithSeconds(duration) {
                withAnimation(Animation.easeInOut(duration: duration)) {
                    self.presenting.toggle()
                }
            }
        }
    }
}

struct SizePreferenceKey: PreferenceKey {
    typealias Value = CGSize
    static var defaultValue: Value = .zero

    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}

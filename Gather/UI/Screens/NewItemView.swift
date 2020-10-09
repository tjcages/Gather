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

    // MARK: - Private Properties

    @State private var keyboardShowing = false
    @State var offset: CGFloat = 0
    @State private var showSchedule: Bool = false

    let threshold: CGFloat = 100

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
                .offset(y: showing ? offset : 364)
                .animation(.interactiveSpring())
                .gesture(dragGesture())
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
                let notifier = NotificationCenter.default
                let willShow = UIResponder.keyboardWillShowNotification
                let willHide = UIResponder.keyboardWillHideNotification
                notifier.addObserver(forName: willShow, object: nil, queue: .main, using: self.keyboardShow)
                notifier.addObserver(forName: willHide, object: nil, queue: .main, using: self.keyboardHide)

                showDisplay()
            }
            .onDisappear {
                let notifier = NotificationCenter.default
                notifier.removeObserver(self)
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

// MARK: - Drag Gesture & Handler
extension NewItemView {

    /// Create a new **DragGesture** with *updating* and *onEndend* func
    private func dragGesture() -> _EndedGesture<_ChangedGesture<DragGesture>> {
        DragGesture(minimumDistance: 30, coordinateSpace: .local)
            .onChanged(onDragChanged)
            .onEnded(onDragEnded)
    }

    private func onDragChanged(drag: DragGesture.Value) {
        let translation = drag.translation.height
        let stiffness: CGFloat = 0.3

        if translation < -threshold {
            // Expand
            print("expand")
        } else {
            offset = translation * stiffness
        }
    }

    // The method called when the drag ends. It moves the sheet in the correct position based on the last drag gesture
    private func onDragEnded(drag: DragGesture.Value) {
        let predictedTranslation = drag.predictedEndTranslation.height

        if predictedTranslation > threshold {
            if keyboardShowing {
                dismissKeyboard()
            } else {
                dismiss()
            }
        } else if predictedTranslation < -threshold {
            // Expand
            print("Expand") // Going to have to set bool for add item
            offset = 0
        } else {
            offset = 0
        }
    }
}

// MARK: - Keyboard Handlers Methods
extension NewItemView {

    // Add the keyboard offset
    private func keyboardShow(notification: Notification) {
        let endFrame = UIResponder.keyboardFrameEndUserInfoKey
        if let rect: CGRect = notification.userInfo![endFrame] as? CGRect {
            let height = rect.height
            let bottomInset = UIApplication.shared.windows.first?.safeAreaInsets.bottom
            withAnimation(Animation.easeOut(duration: Animation.animationIn)) {
                self.keyboardShowing = true
                self.offset = -height + (bottomInset ?? 0)
            }
        }
    }

    // Remove the keyboard offset
    private func keyboardHide(notification: Notification) {
        DispatchQueue.main.async {
            withAnimation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0)) {
                self.offset = 0
            }
        }
    }

    // Dismiss the keyboard
    private func dismissKeyboard() {
        DispatchQueue.main.async {
            withAnimation(Animation.easeOut(duration: Animation.animationIn)) {
                self.keyboardShowing = false
            }
            UIApplication.shared.endEditing()
        }
    }
}

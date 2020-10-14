//
//  RoutineCellViewModel.swift
//  Gather
//
//  Created by Tyler Cagle on 10/14/20.
//

import Foundation
import Combine
import Resolver

class RoutineCellViewModel: ObservableObject, Identifiable {
    @Injected var routineRepository: RoutineRepository

    @Published var routine: Routine

    var id: String = ""

    private var cancellables = Set<AnyCancellable>()

    static func newRoutine() -> RoutineCellViewModel {
        RoutineCellViewModel(routine: Routine(title: "", startTime: Date(), endTime: Date(), color: "blue"))
    }

    init(routine: Routine) {
        self.routine = routine

//        $routine
//            .map { $0.completed ? "checkmark.circle.fill" : "circle" }
//            .assign(to: \.completionStateIconName, on: self)
//            .store(in: &cancellables)

        $routine
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)

        $routine
            .dropFirst()
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink { [weak self] task in
                self?.routineRepository.updateRoutine(routine)
            }
            .store(in: &cancellables)
    }

}

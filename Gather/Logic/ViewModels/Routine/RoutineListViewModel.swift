//
//  RoutineListViewModel.swift
//  Gather
//
//  Created by Tyler Cagle on 10/14/20.
//

import Foundation
import Combine
import Resolver

class RoutineListViewModel: ObservableObject {
    @Published var routineRepository: RoutineRepository = Resolver.resolve()
    @Published var routineCellViewModels = [RoutineCellViewModel]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        routineRepository.$routines.map { routines in
            routines.map { routine in
                RoutineCellViewModel(routine: routine)
            }
        }
            .assign(to: \.routineCellViewModels, on: self)
            .store(in: &cancellables)
    }

    func removeRoutine(atOffsets indexSet: IndexSet) {
        // Remove from repo
        let viewModels = indexSet.lazy.map { self.routineCellViewModels[$0] }
        viewModels.forEach { routineCellViewModel in
            routineRepository.removeRoutine(routineCellViewModel.routine)
        }
    }

    func addRoutine(routine: Routine) {
        routineRepository.addRoutine(routine)
    }
}

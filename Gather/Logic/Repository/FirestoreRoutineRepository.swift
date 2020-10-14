//
//  FirestoreRoutineRepository.swift
//  Gather
//
//  Created by Tyler Cagle on 10/14/20.
//

import Foundation

import FirebaseFirestore
import FirebaseFirestoreSwift

import Resolver
import Combine

class BaseRoutineRepository {
    @Published var routines = [Routine]()
}

protocol RoutineRepository: BaseRoutineRepository {
    func addRoutine(_ routine: Routine)
    func removeRoutine(_ routine: Routine)
    func updateRoutine(_ routine: Routine)
}

class FirestoreRoutineRepository: BaseRoutineRepository, RoutineRepository, ObservableObject {
    var database = Firestore.firestore()
    @Injected var authenticationService: AuthenticationService

    var routinesPath: String = "routines"
    var userId: String = "unknown"

    private var listenerRegistration: ListenerRegistration?
    private var cancellables = Set<AnyCancellable>()

    override init() {
        super.init()

        authenticationService.$user
            .compactMap { user in
                user?.uid
            }
            .assign(to: \.userId, on: self)
            .store(in: &cancellables)

        // Reload data if user changes
        authenticationService.$user
            .receive(on: DispatchQueue.main)
            .sink { user in
                self.loadData()
            }
            .store(in: &cancellables)
    }

    private func loadData() {
        // Pull data from Firestore
        // Organize data based on 'createdTime' <- will need update
        if listenerRegistration != nil {
            listenerRegistration?.remove()
        }
        listenerRegistration = database.collection(routinesPath)
            .whereField("userId", isEqualTo: self.userId)
            .order(by: "startTime")
            .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    self.routines = querySnapshot.documents.compactMap { document -> Routine? in
                        try? document.data(as: Routine.self)
                    }
                }
        }
    }

    func addRoutine(_ routine: Routine) {
        do {
            var userRoutine = routine
            userRoutine.userId = self.userId
            userRoutine.updatedTime = nil
            let _ = try database.collection(routinesPath).addDocument(from: userRoutine)
        }
        catch {
            print("There was an error while trying to save a task: \(error.localizedDescription).")
        }
    }

    func removeRoutine(_ routine: Routine) {
        if let routineID = routine.id {
            database.collection(routinesPath).document(routineID).delete { (error) in
                if let error = error {
                    print("Error removing document: \(error.localizedDescription).")
                }
            }
        }
    }

    func updateRoutine(_ routine: Routine) {
        if let routineID = routine.id {
            do {
                var updatedRoutine = routine
                updatedRoutine.updatedTime = nil
                try database.collection(routinesPath).document(routineID).setData(from: updatedRoutine)
            }
            catch {
                print("There was an error while trying to update a task: \(error.localizedDescription).")
            }
        }
    }

}


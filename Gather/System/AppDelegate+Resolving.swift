//
//  AppDelegate+Resolving.swift
//  Gather
//
//  Created by Tyler Cagle on 9/28/20.
//

import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        register { TestDataTaskRepository() as TaskRepository }.scope(application)
    }
}

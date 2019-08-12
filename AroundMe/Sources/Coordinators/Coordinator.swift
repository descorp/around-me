//
//  Coordinator.swift
//  AroundMeApp
//
//  Created by Vladimir Abramichev on 09/08/2019.
//

import UIKit

class Coordinator: Identifiable {
    var id = UUID()
    
    private(set) var childCoordinators: Set<Coordinator> = []
    
    weak var parentCoordinator: Coordinator?
    
    var rootNavigation: UINavigationController?
    
    init(rootNavigation: UINavigationController, parentCoordinator: Coordinator? = nil) {
        self.rootNavigation = rootNavigation
        self.parentCoordinator = parentCoordinator
        if let parentCoordinator = parentCoordinator {
            parentCoordinator.childCoordinators.insert(self)
        }
    }
    
    init(parentCoordinator: Coordinator? = nil) {
        self.parentCoordinator = parentCoordinator
        if let parentCoordinator = parentCoordinator {
            rootNavigation = parentCoordinator.rootNavigation
            parentCoordinator.childCoordinators.insert(self)
        }
    }
    
    func start() {
        preconditionFailure("This method needs to be overriden by concrete subclass.")
    }
    
    func finish() {
        if let parentCoordinator = parentCoordinator {
            rootNavigation = parentCoordinator.rootNavigation
            parentCoordinator.childCoordinators.remove(self)
        }
    }
}

extension Coordinator {

    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.insert(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.remove(coordinator)
    }
    
    func removeAllChildCoordinatorsWith<T>(type: T.Type) {
        for coordinator in childCoordinators.filter({ $0 is T }) {
            removeChildCoordinator(coordinator)
        }
    }
    
    func removeAllChildCoordinators() {
        for coordinator in childCoordinators {
            coordinator.finish()
        }
        childCoordinators.removeAll()
    }
}

extension Coordinator: Hashable {
    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

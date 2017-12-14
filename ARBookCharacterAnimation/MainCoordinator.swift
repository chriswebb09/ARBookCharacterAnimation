//
//  MainCoordinator.swift
//  ARBookCharacterAnimation
//
//  Created by Christopher Webb-Orenstein on 12/13/17.
//  Copyright © 2017 Christopher Webb. All rights reserved.
//

import SceneKit

final class MainCoordinator: AppCoordinator {
    
    weak var delegate: ControllerCoordinatorDelegate?
    
    var childCoordinators: [ControllerCoordinator] = []
    var window: UIWindow
    
    // var locationData: LocationData!
    
    init(window: UIWindow) {
        self.window = window
        transitionCoordinator(type: .start)
    }
    
    func addChildCoordinator(_ childCoordinator: ControllerCoordinator) {
        childCoordinator.delegate = self
        childCoordinators.append(childCoordinator)
    }
    
    func removeChildCoordinator(_ childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
}

extension MainCoordinator: ControllerCoordinatorDelegate {
    func transitionCoordinator(type: CoordinatorType) {
        childCoordinators.removeAll()
        switch type {
        case .app:
            print("app")
        case .start:
            let startCoordinator = StartControllerCoordinator(window: window)
            addChildCoordinator(startCoordinator)
            startCoordinator.delegate = self
            startCoordinator.type = .start
            startCoordinator.start()
        }
    }
    

}

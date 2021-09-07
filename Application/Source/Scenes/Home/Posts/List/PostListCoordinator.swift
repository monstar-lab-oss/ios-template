//
//  PostCoordinator.swift
//  Template
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Domain
import class UIKit.UIViewController

class PostListCoordinator: NavigationCoordinator {
    
    // MARK: - Properties
    private let useCaseProvider: UseCaseProvider
    
    // MARK: - Init
    init(useCaseProvider: UseCaseProvider) {
        self.useCaseProvider = useCaseProvider
        super.init()
    }
    
    // MARK: - Start and show root scene
    override func start() {
        super.start()
        let scene = PostListScene(
            dependencies: .init(
                coordinator: self.eraseToAnyCoordinatable(),
                useCaseProvider: useCaseProvider
            )
        )
        self.navigationController.setViewControllers([scene.view], animated: false)
    }
}

// MARK: - ViewModel → Coordinator　Callbacks
extension PostListCoordinator: Coordinatable {

    func coordinate(to route: PostListScene.Route) {
        switch route {
        case .detail(let id):
            showPostDetail(id: id)
        }
    }

    private func showPostDetail(id: Int) {
        let coordinator = PostDetailCoordinator(
            navigationController: navigationController,
            useCaseProvider: useCaseProvider,
            postId: id
        )
        addChild(coordinator)
        coordinator.parentCoordinator = self.eraseToAnyCoordinator()
        coordinator.start()
    }
}


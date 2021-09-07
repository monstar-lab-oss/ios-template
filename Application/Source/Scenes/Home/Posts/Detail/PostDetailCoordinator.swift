//
//  PostDetailCoordinator.swift
//  Template
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Domain
import UIKit.UIViewController

class PostDetailCoordinator: NavigationCoordinator {

    // MARK: - Properties
    private let useCaseProvider: UseCaseProvider
    private let postId: Int
    
    // MARK: - Init
    init(navigationController: UINavigationController, useCaseProvider: UseCaseProvider, postId: Int) {
        self.useCaseProvider = useCaseProvider
        self.postId = postId
        super.init(viewController: navigationController)
    }

    override func start() {
        super.start()
        let scene = PostDetailScene(
            dependencies: .init(
                postId: postId,
                coordinator: self.eraseToAnyCoordinatable(),
                useCaseProvider: useCaseProvider
            )
        )
        self.navigationController.pushViewController(scene.view, animated: true)
    }
}

extension PostDetailCoordinator: Coordinatable {

    func coordinate(to route: PostDetailScene.Route) {
        
    }
}

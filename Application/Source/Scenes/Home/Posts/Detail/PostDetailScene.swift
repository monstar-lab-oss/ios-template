//
//  PostDetailScene.swift
//  Template
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Domain
import UIKit.UIViewController
import UIKit.UIStoryboard

final class PostDetailScene: Scene {
    // MARK: - Enums and Declarations
    enum Route {
        // This Coordinator has no `enum Route`.
        // It literally means that this is the last screen and no further navigation is possible,
        // though you can go back. 😉
    }
    
    struct Dependencies {
        let postId: Int
        let coordinator: AnyCoordinatable<Route>
        let useCaseProvider: UseCaseProvider
    }

    // MARK: - Properties
    let view: PostDetailViewController
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        view = PostDetailViewController.instantiate(
            with: PostDetailViewModel(
                postId: dependencies.postId,
                coordinator: dependencies.coordinator,
                useCases: PostDetailViewModel.UseCases(
                    getPostDetailUseCase: dependencies.useCaseProvider.makeGetPostDetailUseCase(),
                    getPostCommentsUseCase: dependencies.useCaseProvider.makeGetPostCommentsUseCase(dependencies.postId))
            )
        )
    }
}


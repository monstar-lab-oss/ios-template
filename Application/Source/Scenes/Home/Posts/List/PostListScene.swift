//
//  PostListScene.swift
//  Template
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Domain
import class UIKit.UIViewController

final class PostListScene: Scene {
    
    // MARK: - Enums and Declarations
    enum Route {
        case detail(id: Int)
    }
    
    struct Dependencies {
        let coordinator: AnyCoordinatable<Route>
        let useCaseProvider: UseCaseProvider
    }
    
    // MARK: - Properties
    let view: PostListViewController
    
    // MARK: - Init
    init(dependencies: Dependencies) {
        let useCase = dependencies.useCaseProvider.makeGetPostsUseCase()
        view = PostListViewController.instantiate(
            with: PostListViewModel(
                coordinator: dependencies.coordinator,
                useCase: useCase
            )
        )
    }
}


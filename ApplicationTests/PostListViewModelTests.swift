//
//  PostListViewModelTests.swift
//  TemplateTests
//
//  Created by Aarif Sumra on 2021/09/02.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import XCTest
import Combine
import Domain
@testable import Template

class PostListViewModelTests: XCTestCase {
    
    var sut: PostListViewModel!
    var cancellables: Set<AnyCancellable>!

    private var refresh: PassthroughSubject<Void, Never>!
    private var itemSelected: PassthroughSubject<Int, Never>!
    private var loadMore: PassthroughSubject<Void, Never>!
    private var input: PostListViewModel.Input!
    private var output: PostListViewModel.Output!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        cancellables = []
        sut = PostListViewModel(
            coordinator: MockCoordinator().eraseToAnyCoordinatable(),
            useCase: MockUseCase().eraseToAnyUseCase()
        )
        
        refresh = PassthroughSubject<Void, Never>()
        itemSelected = PassthroughSubject<Int, Never>()
        loadMore = PassthroughSubject<Void, Never>()
        
        input = PostListViewModel.Input(
            refresh: refresh.eraseToAnyPublisher(),
            itemSelected: itemSelected.eraseToAnyPublisher(),
            loadMore: loadMore.eraseToAnyPublisher()
        )
        output = sut.transform(input)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

}

private class MockCoordinator: NavigationCoordinator, Coordinatable {
    func coordinate(to route: PostListScene.Route) {
    
    }
}

private class MockUseCase: UseCase {
    func execute(_ parameters: Void, completion: ((Result<[PostEntity], Error>) -> Void)?) {
        
    }
}

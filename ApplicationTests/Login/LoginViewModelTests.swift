//
//  LoginViewModelTests.swift
//  TemplateTests
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import XCTest
import Combine
import Domain
@testable import Template

class LoginViewModelTests: XCTestCase {

    var sut: LoginViewModel!
    var cancellables: Set<AnyCancellable>!

    private var username: PassthroughSubject<String?, Never>!
    private var password: PassthroughSubject<String?, Never>!
    private var loginTap: PassthroughSubject<Void, Never>!
    private var input: LoginViewModel.Input!
    private var output: LoginViewModel.Output!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        cancellables = []
        sut = LoginViewModel(
            coordinator: MockCoordinator().eraseToAnyCoordinatable(),
            useCase: MockUseCase().eraseToAnyUseCase()
        )
        username = PassthroughSubject<String?, Never>()
        password = PassthroughSubject<String?, Never>()
        loginTap = PassthroughSubject<Void, Never>()
        input = LoginViewModel.Input(
            username: username.eraseToAnyPublisher(),
            password: password.eraseToAnyPublisher(),
            doLogin: loginTap.eraseToAnyPublisher()
        )
        output = sut.transform(input)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testEnablesLoginButtonWhenUsernameIsEmail() {
        let receivedAllValues = expectation(description: "received all values")
        let expectedValues = [false, false, false, true]
        var result = [Bool]()

        output.enableLogin.sink { enabled in
            result.append(enabled)
            if enabled {
                receivedAllValues.fulfill()
            }
        }.store(in: &cancellables)

        password.send("xxxxxxxxx") // Valid Password Count > 6

        username.send("a")
        username.send("a@b")
        username.send("a@b.")
        username.send("a@b.c")

        waitForExpectations(timeout: 1) { error in
            if error != nil {
                XCTFail(error.debugDescription)
            }
        }

        XCTAssert(result.elementsEqual(expectedValues))
    }

    func testEnablesLoginButtonWhenPasswordCountMoreThanSix() {
        let receivedAllValues = expectation(description: "received all values")
        let expectedValues = [false, true]
        var result = [Bool]()

        output.enableLogin.sink { enabled in
            result.append(enabled)
            if enabled {
                receivedAllValues.fulfill()
            }
        }.store(in: &cancellables)

        username.send("a@b.c") // Valid Email Format

        password.send("1234567")
        password.send("12345678")

        print(result)

        waitForExpectations(timeout: 1) { error in
            if error != nil {
                XCTFail(error.debugDescription)
            }
        }

        XCTAssert(result.elementsEqual(expectedValues), "Validates Email")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

private class MockCoordinator: NavigationCoordinator, Coordinatable {
    func coordinate(to route: LoginScene.Route) {
    
    }
}

private class MockUseCase: UseCase {
    func execute(_ parameters: (username: String, password: String), completion: ((Result<Bool, Error>) -> Void)?) {
        
    }
}

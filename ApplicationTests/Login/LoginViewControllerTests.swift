//
//  LoginViewControllerTests.swift
//  TemplateTests
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import XCTest
import Combine
import Domain
@testable import Template

private class LoginViewControllerMirror: MirrorObject {

    var loginHeaderLabel: UILabel! { extract() }
    var userNameTextField: UITextField! { extract() }
    var passwordTextField: UITextField! { extract() }
    var loginButton: UIButton! { extract() }
    var loginFooterLabel: UILabel! { extract() }
    var scrollView: UIScrollView! { extract() }

    init(viewController: LoginViewController) {
        super.init(subject: viewController)
    }
}

class LoginViewControllerTests: XCTestCase {

    private var sut: LoginViewController!
    private var sutMirror: LoginViewControllerMirror!
    private var mockViewModel: MockLoginViewModel!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        sut = storyboard.instantiateInitialViewController() as? LoginViewController
        sutMirror = LoginViewControllerMirror(viewController: sut)
        mockViewModel = MockLoginViewModel(
            coordinator: MockCoordinator().eraseToAnyCoordinatable(),
            useCase: MockUseCase().eraseToAnyUseCase()
        )
        sut.viewModel = mockViewModel
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_UserNameTextField_Setup() throws {
        let textField = try XCTUnwrap(sutMirror.userNameTextField, "userNameTextField is not connected")
        // Configurations
        XCTAssertEqual(textField.textContentType, UITextContentType.emailAddress, "userNameTextField does not have an Email Address Content Type set")
        XCTAssertEqual(textField.placeholder, "Email", "userNameTextField placeholder is not correct or set")
    }

    func test_UserNameTextField_Bindings() throws {
        weak var textExpectation = expectation(description: "should received text")
        let expectedValue = "Sample Text"
        var result = ""
        let subscription = mockViewModel.username.compactMap { $0 }
            .sink { text in
                result = text
                if !result.isEmpty {
                    textExpectation?.fulfill()
                }
            }
        sutMirror.userNameTextField.text = "Sample Text"
        sutMirror.userNameTextField.sendActions(for: .editingChanged)
        waitForExpectations(timeout: 1) { error in
            if error != nil {
                XCTFail(error.debugDescription)
                subscription.cancel()
            }
        }
        XCTAssertEqual(result, expectedValue)
        subscription.cancel()
    }

    func test_PasswordTextField_Setup() throws {
        let textField = try XCTUnwrap(sutMirror.passwordTextField, "passwordTextField is not connected")
        XCTAssertEqual(textField.textContentType, UITextContentType.password, "passwordTextField does not have an Password Content Type set")
        XCTAssertEqual(textField.placeholder, "Password", "passwordTextField placeholder is not correct or set")
        XCTAssertTrue(textField.isSecureTextEntry, "passwordTextField is not a Secure Text Entry Field")
    }

    func test_PasswordTextField_Bindings() throws {
        let textExpectation = expectation(description: "should received text")
        let expectedValue = "Sample Text"
        var result = ""
        let subscription = mockViewModel.username.compactMap { $0 }
            .sink { text in
                result = text
                if !result.isEmpty {
                    textExpectation.fulfill()
                }
            }
        sutMirror.userNameTextField.text = "Sample Text"
        sutMirror.userNameTextField.sendActions(for: .editingChanged)
        waitForExpectations(timeout: 1) { error in
            if error != nil {
                XCTFail(error.debugDescription)
                subscription.cancel()
            }
        }
        XCTAssertEqual(result, expectedValue)
        subscription.cancel()
    }

    func test_LoginButton_Setup() throws {
        let button = try XCTUnwrap(sutMirror.loginButton, "loginButton is not connected")
        XCTAssertEqual(button.titleLabel?.text, "Login", "loginButton does not have an Password Content Type set")
        XCTAssertTrue(button.isEnabled, "loginButton is disabled when loaded")
    }

    func test_LoginButton_Bindings() throws {
        let tapExpectation = expectation(description: "should received tap event")
        let expectedValue = 1
        var tapCount = 0
        let subscription = mockViewModel.doLogin.sink { _ in
            tapCount += 1
            if tapCount > 0 {
                tapExpectation.fulfill()
            }
        }
        sutMirror.loginButton.sendActions(for: .touchUpInside)
        waitForExpectations(timeout: 1) { error in
            if error != nil {
                XCTFail(error.debugDescription)
                subscription.cancel()
            }
        }
        XCTAssertEqual(tapCount, expectedValue)
        subscription.cancel()
    }

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
}

private class MockLoginViewModel: LoginViewModel {
    // Data
    var username: AnyPublisher<String?, Never>!
    var password: AnyPublisher<String?, Never>!
    // Actions
    var doLogin: AnyPublisher<Void, Never>!

    override func transform(_ input: LoginViewModel.Input) -> LoginViewModel.Output {
        username = input.username
        password = input.password
        doLogin = input.doLogin
        return super.transform(input)
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

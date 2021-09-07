//
//  LoginViewController.swift
//  Template
//
//  Created by Aarif Sumra on 2021-09-01.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import UIKit
import Combine
import CombineCocoa

final class LoginViewController: UIViewController, StoryboardInstantiatable, ViewType {
    
    // MARK: - Statics
    static var storyboardName  = "Login"
    
    // MARK: - Outlets
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    // MARK: - Properties
    var viewModel: LoginViewModel!
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        performBinding()
    }
    
    func performBinding() {
        let viewModelInput = ViewModel.Input(
            username: userNameTextField.textPublisher,
            password: passwordTextField.textPublisher,
            doLogin: loginButton.tapPublisher
        )

        let viewModelOutput = viewModel.transform(viewModelInput)

        viewModelOutput.enableLogin.prepend(false)
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: loginButton)
            .store(in: &cancellables)

        scrollView.registerForKeyboardEvents(with: &cancellables)
    }
}

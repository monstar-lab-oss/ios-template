//
//  LoginViewController.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import UIKit
import Combine
import CombineCocoa

class LoginViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet private weak var loginHeaderLabel: UILabel! {
        didSet {
            loginHeaderLabel.font = UIFont.preferredFont(forTextStyle: .headline)
            loginHeaderLabel.numberOfLines = 0
            loginHeaderLabel.text = lo.defaultSection.loginPlease
        }
    }

    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var loginFooterLabel: UILabel! {
        didSet {
            loginFooterLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
            loginFooterLabel.numberOfLines = 0
            loginFooterLabel.text = lo.defaultSection.loginThanks
        }
    }
    @IBOutlet private weak var scrollView: UIScrollView!
    
    // MARK: - Properties
    private var viewModel: LoginViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    class func instantiate(with viewModel: LoginViewModel) -> LoginViewController {
        let name = "Login"
        let storyboard = UIStoryboard(name: name, bundle: nil)

        guard let vc = storyboard.instantiateInitialViewController() as? LoginViewController else {
            preconditionFailure("Unable to instantiate a LoginViewController with the name \(name)")
        }

        vc.viewModel = viewModel
        return vc
    }
    
    // MARK: - View Lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad()

        let viewModelInput = LoginViewModel.Input(
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

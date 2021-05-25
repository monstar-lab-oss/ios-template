//
//  {{cookiecutter.domain_model}}DetailViewController.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import UIKit
import Combine

class {{cookiecutter.domain_model}}DetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!


    // MARK: - Properties
    private var viewModel: {{cookiecutter.domain_model}}DetailViewModel!
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    class func instantiate(with viewModel: {{cookiecutter.domain_model}}DetailViewModel) -> {{cookiecutter.domain_model}}DetailViewController {
        let name = "{{cookiecutter.domain_model}}Detail"
        let storyboard = UIStoryboard(name: name, bundle: nil)

        guard let vc = storyboard.instantiateInitialViewController() as? {{cookiecutter.domain_model}}DetailViewController else {
            preconditionFailure("Unable to instantiate a {{cookiecutter.domain_model}}DetailViewController with the name \(name)")
        }

        vc.viewModel = viewModel
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel?.transform(
            .init(
                loadData: Just(()).eraseToAnyPublisher()
            )
        ).result.receive(on: RunLoop.main)
        .sink(receiveValue: { result in
            switch result {
            case .success(let item):
                self.titleLabel.text = item.title
                self.descriptionLabel.text = item.body
            case .failure(_):
                print("No {{cookiecutter.domain_model|lower}}s found")
            }
        }).store(in: &cancellables)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

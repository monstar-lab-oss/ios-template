//
//  {{cookiecutter.domain_model}}DetailViewModel.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import Foundation

class {{cookiecutter.domain_model}}DetailViewModel {

    var coordinator: AnyCoordinatable<{{cookiecutter.domain_model}}DetailRoute>?

    init({{cookiecutter.domain_model|lower}}Id: Int) {
        print(#function)
        print({{cookiecutter.domain_model|lower}}Id)
    }
}

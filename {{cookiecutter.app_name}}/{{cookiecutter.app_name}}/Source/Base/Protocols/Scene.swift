//
//  Scene.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import UIKit.UIViewController

protocol Scene {
    associatedtype Dependencies
    var viewController: UIViewController { get }
}

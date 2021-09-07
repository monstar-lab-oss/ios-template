//
//  ViewType.swift
//  BoxOffice
//
//  Created by Aarif Sumra on 2021/07/15.
//  Copyright © 2021 Monstar-Lab Inc. All rights reserved.
//

import Foundation
import Combine
import UIKit.UIView

public protocol ViewType: class {
    associatedtype ViewModel: ViewModelType
    var view: UIView! { get }
    var viewModel: ViewModel! { get set }
    
    static func instantiate(with viewModel: ViewModel) -> Self
    func performBinding()
}

extension ViewType where Self: UIViewController & StoryboardInstantiatable {
    
    static func instantiate(with viewModel: ViewModel) -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        
        if let identifier = storyboardIdentifier {
            guard let vc = storyboard.instantiateViewController(identifier: identifier) as? Self else {
                preconditionFailure("Unable to instantiate \(Self.self) from the storyboard named \(storyboardName) with identifer \(identifier)")
            }
            vc.viewModel = viewModel
            return vc
        }
        
        guard let vc = storyboard.instantiateInitialViewController() as? Self else {
            preconditionFailure("Unable to instantiate initial \(Self.self) from the storyboard named \(storyboardName)")
        }
        vc.viewModel = viewModel
        return vc
    }
}




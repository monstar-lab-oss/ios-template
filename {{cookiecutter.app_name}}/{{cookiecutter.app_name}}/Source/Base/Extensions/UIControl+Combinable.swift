//
//  UIControl+Combine.swift
//  {{cookiecutter.app_name}}
//
//  Created by {{cookiecutter.lead_dev_name}} on {% now 'local' %}.
//  Copyright © {% now 'local', '%Y' %} {{cookiecutter.company_name}} All rights reserved.
//

import UIKit.UIControl
import Combine

extension UIControl: Combinable {}

extension Combinable where Self: UIControl {
    /// Returns a publisher that emits events when action sent on control.
    ///
    /// - Parameters:
    ///   - event: The event to publish.
    /// - Returns: A publisher that emits events when action taken on control.
    func publisher(for event: Event) -> UIControl.EventPublisher {
        return UIControl.EventPublisher(control: self, controlEvent: event)
    }
}

extension UIControl {
    struct EventPublisher: Publisher {
        /// The kind of values published by this publisher.
        typealias Output = UIControl
        /// The kind of errors this publisher might publish.
        ///
        /// Using `Never` since this `Publisher` does not publish errors.
        typealias Failure = Never

        /// The control  this publisher uses as a source.
        let control: UIControl

        /// The type of event published by this publisher.
        let controlEvent: UIControl.Event

        /// Connecting publisher and subscriber with subscription
        func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = EventSubscription(control: control, event: controlEvent, subscriber: subscriber)
            subscriber.receive(subscription: subscription)
        }
    }
}

private extension UIControl.EventPublisher {

    final class EventSubscription<S: Subscriber>: Subscription where S.Input == UIControl, S.Failure == Never {

        private let control: UIControl
        private let event: UIControl.Event
        private var subscriber: S?
        // Controlling back pressure
        private var currentDemand: Subscribers.Demand = .none

        init(control: UIControl, event: UIControl.Event, subscriber: S) {
            self.control = control
            self.event = event
            self.subscriber = subscriber
            control.addTarget(self,
                              action: #selector(performAction),
                              for: event)
        }

        func request(_ demand: Subscribers.Demand) {
            currentDemand += demand
        }

        func cancel() {
            subscriber = nil
            control.removeTarget(self,
                                 action: #selector(performAction),
                                 for: event)
        }

        @objc private func performAction() {
            if currentDemand > 0 {
                currentDemand += subscriber?.receive(control) ?? .none
                currentDemand -= 1
            }
        }
    }
}

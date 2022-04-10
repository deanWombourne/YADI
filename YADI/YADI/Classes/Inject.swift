//
//  Inject.swift
//  YADI
//
//  Created by Sam Dean on 10/04/2022.
//

import Foundation
import ObjectiveC

@propertyWrapper
public struct Inject<T> {

    private var wrapped: T?

    private let container: Container

    public init(_ container: Container = .shared) {
        self.container = container
    }

    public var wrappedValue: T {
        mutating get {
            if self.wrapped == nil {
                self.wrapped = self.container.resolve() as T
            }

            return self.wrapped!
        }
    }
}

@propertyWrapper
public struct MutableInject<T: AnyObject> {

    private var wrapped: T?

    public init() { }

    public var wrappedValue: T {
        mutating get {
            if self.wrapped == nil {
                self.wrapped = Container.shared.resolve()
            }

            return self.wrapped!
        }
        mutating set {
            self.wrapped = newValue
        }
    }
}

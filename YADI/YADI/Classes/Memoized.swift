//
//  Memoized.swift
//  YADI
//
//  Created by Sam Dean on 10/04/2022.
//

import Foundation

func memoized<T>(_ wrapped: @escaping () -> T) -> () -> T {
    var cached: T?

    return {
        if cached == nil {
            cached = wrapped()
        }

        return cached!
    }
}

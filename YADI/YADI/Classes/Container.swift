//
//  Container.swift
//  YADI
//
//  Created by Sam Dean on 10/04/2022.
//

import Foundation

private struct Generator {
    let label: String
    let function: () -> Any
}

public class Container {

    public static let shared = Container()

    private var generators: [String: Generator] = [:]

    public func listGenerators() -> [String] {
        return self.generators.map { String(describing: $0.value.label) }
    }

    public func resolve<T>() -> T {
        let key = String(describing: T.self)

        guard let generator = self.generators[key] else {
            fatalError("Failed to generate instance of \(T.self) - no generator found")
        }

        let candidate = generator.function()
        guard let generated = candidate as? T else {
            fatalError("Failed to generate instance of \(T.self) - generator returned \(type(of: candidate))")
        }

        return generated
    }

    public func add<T>(_ generator: @escaping () -> T) {
        let key = String(describing: T.self)
        self.generators[key] = Generator(label: "() -> \(key)", function: memoized(generator))
    }

    func reset() {
        self.generators = [:]
    }
}

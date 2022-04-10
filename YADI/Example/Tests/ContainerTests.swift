@testable import YADI
import XCTest

// Some test types
private final class NoDependencies: Equatable, Hashable {
    let value: String
    init(value: String) { self.value = value }

    static func == (lhs: NoDependencies, rhs: NoDependencies) -> Bool {
        return lhs.value == rhs.value
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.value)
    }
}

private final class HasDependency: Equatable, Hashable {
    let value: String
    @Inject var dependency: NoDependencies
    init(value: String) { self.value = value }

    static func == (lhs: HasDependency, rhs: HasDependency) -> Bool {
        return lhs.value == rhs.value && lhs.dependency.value == rhs.dependency.value
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(self.value)
        hasher.combine(self.dependency.value)
    }
}

final class ContainerTests: XCTestCase {

    override func setUp() async throws {
        try await super.setUp()

        Container.shared.reset()
    }

    func testShouldCreateInstance() {
        // Sanity test, if this is failing then something has gone horribly wrong
        XCTAssertNotNil(Container.shared)
    }

    func testShouldCreateNoDependency() {
        Container.shared.add { NoDependencies(value: "1") }
        let generated: NoDependencies = Container.shared.resolve()
        XCTAssertNotNil(generated)
        XCTAssertEqual(generated.value, "1")
    }

    func testShouldCreateNestedDependencies() {
        Container.shared.add { HasDependency(value: "1") }
        Container.shared.add { NoDependencies(value: "2") }
        let generated: HasDependency = Container.shared.resolve()
        XCTAssertNotNil(generated)
        XCTAssertEqual(generated.value, "1")
        XCTAssertEqual(generated.dependency.value, "2")
    }

    func testShouldNotDuplicateInstances() {
        var count = 0
        Container.shared.add { () -> NoDependencies in
            count += 1
            return NoDependencies(value: UUID().uuidString)
        }

        let generated1: NoDependencies = Container.shared.resolve()
        let generated2: NoDependencies = Container.shared.resolve()
        XCTAssertEqual(count, 1)
        XCTAssertEqual(generated1, generated2)
    }

    func testShouldDuplicateRepeatingInstances() {
        var count = 0
        Container.shared.addRepeating { () -> NoDependencies in
            count += 1
            return NoDependencies(value: UUID().uuidString)
        }

        let generated1: NoDependencies = Container.shared.resolve()
        let generated2: NoDependencies = Container.shared.resolve()
        XCTAssertEqual(count, 2)
        XCTAssertNotEqual(generated1, generated2)
    }
}

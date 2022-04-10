@testable import YADI
import XCTest

// Some test types
private final class NoDependencies {
    let value: String
    init(value: String) { self.value = value }
}

private final class HasDependency {
    let value: String
    @Inject var dependency: NoDependencies
    init(value: String) { self.value = value }
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
}

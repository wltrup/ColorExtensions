import XCTest
@testable import ColorExtensions

#if canImport(SwiftUI)
    import SwiftUI
#endif

final class ColorExtensionsTests: XCTestCase {

    private var mockRNG = MockRNG()

    override func setUp() {
        mockRNG.reset()
    }

    func test_CGFloat_random01() {
        let r = CGFloat.random01(using: &mockRNG)
        XCTAssertTrue(r == mockRNG.nextCGFloat())
    }

    func test_randomRGBA() {

        mockRNG.advance()
        let r = mockRNG.nextCGFloat()

        mockRNG.advance()
        let g = mockRNG.nextCGFloat()

        mockRNG.advance()
        let b = mockRNG.nextCGFloat()

        mockRNG.advance()
        let a = mockRNG.nextCGFloat()

        let expected = ColorType(red: r, green: g, blue: b, alpha: a)

        mockRNG.reset()
        let resulted = ColorType.randomRGBA(using: &mockRNG)

        XCTAssertTrue(resulted == expected)

    }

    func test_randomRGB_custom_alpha() {

        mockRNG.advance()
        let r = mockRNG.nextCGFloat()

        mockRNG.advance()
        let g = mockRNG.nextCGFloat()

        mockRNG.advance()
        let b = mockRNG.nextCGFloat()

        let a_original = CGFloat.random(in: -0.5 ... 1.5)
        let a_clamped = min(max(0, a_original), 1)

        let expected = ColorType(red: r, green: g, blue: b, alpha: a_clamped)

        mockRNG.reset()
        let resulted = ColorType.randomRGB(alpha: a_original, using: &mockRNG)

        XCTAssertTrue(resulted == expected)

    }

    func test_randomRGB_default_alpha() {

        mockRNG.advance()
        let r = mockRNG.nextCGFloat()

        mockRNG.advance()
        let g = mockRNG.nextCGFloat()

        mockRNG.advance()
        let b = mockRNG.nextCGFloat()

        let expected = ColorType(red: r, green: g, blue: b, alpha: 1)

        mockRNG.reset()
        let resulted = ColorType.randomRGB(using: &mockRNG)

        XCTAssertTrue(resulted == expected)

    }

}

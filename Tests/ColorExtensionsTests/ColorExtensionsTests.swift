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
        let resulted = CGFloat.random01(using: &mockRNG)
        let expected = mockRNG.nextCGFloat()
        XCTAssertTrue(resulted == expected,
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")
    }

    func test_init_hexValueRGBA() {

        let r = UInt32(UInt8.random(in: 0 ... .max))
        let g = UInt32(UInt8.random(in: 0 ... .max))
        let b = UInt32(UInt8.random(in: 0 ... .max))
        let a = UInt32(UInt8.random(in: 0 ... .max))

        let fr = CGFloat(r) / 255
        let fg = CGFloat(g) / 255
        let fb = CGFloat(b) / 255
        let fa = CGFloat(a) / 255
        let expected = ColorType(red: fr, green: fg, blue: fb, alpha: fa)

        let hexInt32 = ((r << 8 + g) << 8 + b) << 8 + a
        let resulted = ColorType(hexValueRGBA: hexInt32)

        XCTAssert(resulted == expected,
                  "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_init_hexValueRGB_invalid_input() {

        let expected: ColorType? = nil

        let a = CGFloat.random(in: -0.5 ... 1.5)
        let hexInt32 = 0xFFFFFF + UInt32.random(in: 1 ... 100)
        let resulted = ColorType(hexValueRGB: hexInt32, alpha: a)

        XCTAssert(resulted == expected,
                  "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_init_hexValueRGB_alpha() {

        let r = UInt32(UInt8.random(in: 0 ... .max))
        let g = UInt32(UInt8.random(in: 0 ... .max))
        let b = UInt32(UInt8.random(in: 0 ... .max))
        let a = CGFloat.random(in: -0.5 ... 1.5)

        let fr = CGFloat(r) / 255
        let fg = CGFloat(g) / 255
        let fb = CGFloat(b) / 255
        let fa = min(max(0, a), 1)
        let expected = ColorType(red: fr, green: fg, blue: fb, alpha: fa)

        let hexInt32 = (r << 8 + g) << 8 + b
        let resulted = ColorType(hexValueRGB: hexInt32, alpha: a)

        XCTAssert(resulted == expected,
                  "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_init_hexStringRGBA_invalid_input_1() {

        // more than 9 characters

        let expected: ColorType? = nil
        let resulted = ColorType(hexStringRGBA: "1234567890")

        XCTAssert(resulted == expected,
                  "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_init_hexStringRGBA_invalid_input_2() {

        // 9 characters but doesn't start wth #

        let expected: ColorType? = nil
        let resulted = ColorType(hexStringRGBA: "123456789")

        XCTAssert(resulted == expected,
                  "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_init_hexStringRGBA_invalid_input_3() {

        // 9 characters but contains characters other than 0...9 and A...F

        let expected: ColorType? = nil
        let resulted = ColorType(hexStringRGBA: "#AABGCH0Z")

        XCTAssert(resulted == expected,
                  "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_init_hexStringRGBA() {

        let r = UInt32(UInt8.random(in: 0 ... .max))
        let g = UInt32(UInt8.random(in: 0 ... .max))
        let b = UInt32(UInt8.random(in: 0 ... .max))
        let a = UInt32(UInt8.random(in: 0 ... .max))

        let fr = CGFloat(r) / 255
        let fg = CGFloat(g) / 255
        let fb = CGFloat(b) / 255
        let fa = CGFloat(a) / 255
        let expected = ColorType(red: fr, green: fg, blue: fb, alpha: fa)

        let hexInt32 = ((r << 8 + g) << 8 + b) << 8 + a
        let hexStr = String(hexInt32, radix: 16, uppercase: true)
        let resulted = ColorType(hexStringRGBA: hexStr)

        XCTAssert(resulted == expected,
                  "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_init_hexStringRGB_alpha_invalid_input_1() {

        // more than 7 characters

        let expected: ColorType? = nil
        let resulted = ColorType(hexStringRGB: "12345678", alpha: 0.5)

        XCTAssert(resulted == expected,
                  "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_init_hexStringRGB_alpha_invalid_input_2() {

        // 7 characters but doesn't start wth #

        let expected: ColorType? = nil
        let resulted = ColorType(hexStringRGB: "1234567", alpha: 0.5)

        XCTAssert(resulted == expected,
                  "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_init_hexStringRGB_alpha_invalid_input_3() {

        // 7 characters but contains characters other than 0...9 and A...F

        let expected: ColorType? = nil
        let resulted = ColorType(hexStringRGB: "#AABG0Z", alpha: 0.5)

        XCTAssert(resulted == expected,
                  "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_init_hexStringRGB_alpha() {

        let r = UInt32(UInt8.random(in: 0 ... .max))
        let g = UInt32(UInt8.random(in: 0 ... .max))
        let b = UInt32(UInt8.random(in: 0 ... .max))
        let a = CGFloat.random(in: -0.5 ... 1.5)

        let fr = CGFloat(r) / 255
        let fg = CGFloat(g) / 255
        let fb = CGFloat(b) / 255
        let fa = min(max(0, a), 1)
        let expected = ColorType(red: fr, green: fg, blue: fb, alpha: fa)

        let hexInt32 = (r << 8 + g) << 8 + b
        let hexStr = String(hexInt32, radix: 16, uppercase: true)
        let resulted = ColorType(hexStringRGB: hexStr, alpha: a)

        XCTAssert(resulted == expected,
                  "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_hexStringRGB() {

        let r = UInt32(UInt8.random(in: 0 ... .max))
        let g = UInt32(UInt8.random(in: 0 ... .max))
        let b = UInt32(UInt8.random(in: 0 ... .max))
        let a = CGFloat.random(in: -0.5 ... 1.5)

        let fr = CGFloat(r) / 255
        let fg = CGFloat(g) / 255
        let fb = CGFloat(b) / 255
        let fa = min(max(0, a), 1)
        let color = ColorType(red: fr, green: fg, blue: fb, alpha: fa)

        let hexInt32 = (r << 8 + g) << 8 + b
        let str = String(hexInt32, radix: 16, uppercase: true)
        let gap = 6 - str.count
        let expected = "#" + (gap > 0 ? String(repeating: "0", count: gap) : "") + str

        let resulted = color.hexStringRGB()

        XCTAssert(resulted == .success(expected),
                  "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_hexStringRGBA() {

        let r = UInt32(UInt8.random(in: 0 ... .max))
        let g = UInt32(UInt8.random(in: 0 ... .max))
        let b = UInt32(UInt8.random(in: 0 ... .max))
        let a = UInt32(UInt8.random(in: 0 ... .max))

        let fr = CGFloat(r) / 255
        let fg = CGFloat(g) / 255
        let fb = CGFloat(b) / 255
        let fa = CGFloat(a) / 255
        let color = ColorType(red: fr, green: fg, blue: fb, alpha: fa)

        let hexInt32 = ((r << 8 + g) << 8 + b) << 8 + a
        let str = String(hexInt32, radix: 16, uppercase: true)
        let gap = 8 - str.count
        let expected = "#" + (gap > 0 ? String(repeating: "0", count: gap) : "") + str

        let resulted = color.hexStringRGBA()

        XCTAssert(resulted == .success(expected),
                  "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_randomDisplayP3_alpha_rng() {

        mockRNG.advance()
        let r = mockRNG.nextCGFloat()

        mockRNG.advance()
        let g = mockRNG.nextCGFloat()

        mockRNG.advance()
        let b = mockRNG.nextCGFloat()

        let a_original = CGFloat.random(in: -0.5 ... 1.5)
        let a_clamped = min(max(0, a_original), 1)

        let expected = ColorType(displayP3Red: r, green: g, blue: b, alpha: a_clamped)

        mockRNG.reset()
        let resulted = ColorType.randomDisplayP3(alpha: a_original, using: &mockRNG)

        XCTAssertTrue(resulted == expected,
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_randomDisplayP3_rng() {

        mockRNG.advance()
        let r = mockRNG.nextCGFloat()

        mockRNG.advance()
        let g = mockRNG.nextCGFloat()

        mockRNG.advance()
        let b = mockRNG.nextCGFloat()

        let expected = ColorType(displayP3Red: r, green: g, blue: b, alpha: 1)

        mockRNG.reset()
        let resulted = ColorType.randomDisplayP3(using: &mockRNG)

        XCTAssertTrue(resulted == expected,
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_randomDisplayP3A_rng() {

        mockRNG.advance()
        let r = mockRNG.nextCGFloat()

        mockRNG.advance()
        let g = mockRNG.nextCGFloat()

        mockRNG.advance()
        let b = mockRNG.nextCGFloat()

        mockRNG.advance()
        let a = mockRNG.nextCGFloat()

        let expected = ColorType(displayP3Red: r, green: g, blue: b, alpha: a)

        mockRNG.reset()
        let resulted = ColorType.randomDisplayP3A(using: &mockRNG)

        XCTAssertTrue(resulted == expected,
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_randomRGB_alpha_rng() {

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

        XCTAssertTrue(resulted == expected,
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_randomRGB_rng() {

        mockRNG.advance()
        let r = mockRNG.nextCGFloat()

        mockRNG.advance()
        let g = mockRNG.nextCGFloat()

        mockRNG.advance()
        let b = mockRNG.nextCGFloat()

        let expected = ColorType(red: r, green: g, blue: b, alpha: 1)

        mockRNG.reset()
        let resulted = ColorType.randomRGB(using: &mockRNG)

        XCTAssertTrue(resulted == expected,
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_randomRGBA_rng() {

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

        XCTAssertTrue(resulted == expected,
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_rgbaComponents_invalid_input() {
        // Doesn't seem ever to fail...
    }

    func test_rgbaComponents() {

        let r = UInt32(UInt8.random(in: 0 ... .max))
        let g = UInt32(UInt8.random(in: 0 ... .max))
        let b = UInt32(UInt8.random(in: 0 ... .max))
        let a = UInt32(UInt8.random(in: 0 ... .max))

        let fr = CGFloat(r) / 255
        let fg = CGFloat(g) / 255
        let fb = CGFloat(b) / 255
        let fa = CGFloat(a) / 255

        let expected = ColorType.RGBAComponents(red: fr, green: fg, blue: fb, alpha: fa)
        let resulted = ColorType(red: fr, green: fg, blue: fb, alpha: fa).rgbaComponents()

        XCTAssertTrue(resulted == .success(expected),
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_randomHSB_alpha_rng() {

        mockRNG.advance()
        let h = mockRNG.nextCGFloat()

        mockRNG.advance()
        let s = mockRNG.nextCGFloat()

        mockRNG.advance()
        let b = mockRNG.nextCGFloat()

        let a_original = CGFloat.random(in: -0.5 ... 1.5)
        let a_clamped = min(max(0, a_original), 1)

        let expected = ColorType(hue: h, saturation: s, brightness: b, alpha: a_clamped)

        mockRNG.reset()
        let resulted = ColorType.randomHSB(alpha: a_original, using: &mockRNG)

        XCTAssertTrue(resulted == expected,
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_randomHSB_rng() {

        mockRNG.advance()
        let h = mockRNG.nextCGFloat()

        mockRNG.advance()
        let s = mockRNG.nextCGFloat()

        mockRNG.advance()
        let b = mockRNG.nextCGFloat()

        let expected = ColorType(hue: h, saturation: s, brightness: b, alpha: 1)

        mockRNG.reset()
        let resulted = ColorType.randomHSB(using: &mockRNG)

        XCTAssertTrue(resulted == expected,
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_randomHSBA_rng() {

        mockRNG.advance()
        let h = mockRNG.nextCGFloat()

        mockRNG.advance()
        let s = mockRNG.nextCGFloat()

        mockRNG.advance()
        let b = mockRNG.nextCGFloat()

        mockRNG.advance()
        let a = mockRNG.nextCGFloat()

        let expected = ColorType(hue: h, saturation: s, brightness: b, alpha: a)

        mockRNG.reset()
        let resulted = ColorType.randomHSBA(using: &mockRNG)

        XCTAssertTrue(resulted == expected,
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_hsbaComponents_invalid_input() {
        // Doesn't seem ever to fail...
    }

    func test_hsbaComponents() {

        let h = UInt32(UInt8.random(in: 0 ... .max))
        let s = UInt32(UInt8.random(in: 0 ... .max))
        let b = UInt32(UInt8.random(in: 0 ... .max))
        let a = UInt32(UInt8.random(in: 0 ... .max))

        let fh = CGFloat(h) / 255
        let fs = CGFloat(s) / 255
        let fb = CGFloat(b) / 255
        let fa = CGFloat(a) / 255

        let expected = ColorType.HSBAComponents(hue: fh, saturation: fs, brightness: fb, alpha: fa)
        let resulted = ColorType(hue: fh, saturation: fs, brightness: fb, alpha: fa).hsbaComponents()

        XCTAssertTrue(resulted == .success(expected),
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_randomWhite_alpha_rng() {

        mockRNG.advance()
        let w = mockRNG.nextCGFloat()

        let a_original = CGFloat.random(in: -0.5 ... 1.5)
        let a_clamped = min(max(0, a_original), 1)

        let expected = ColorType(white: w, alpha: a_clamped)

        mockRNG.reset()
        let resulted = ColorType.randomWhite(alpha: a_original, using: &mockRNG)

        XCTAssertTrue(resulted == expected,
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_randomWhite_rng() {

        mockRNG.advance()
        let w = mockRNG.nextCGFloat()

        let expected = ColorType(white: w, alpha: 1)

        mockRNG.reset()
        let resulted = ColorType.randomWhite(using: &mockRNG)

        XCTAssertTrue(resulted == expected,
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_randomWhiteAndAlpha_rng() {

        mockRNG.advance()
        let w = mockRNG.nextCGFloat()

        mockRNG.advance()
        let a = mockRNG.nextCGFloat()

        let expected = ColorType(white: w, alpha: a)

        mockRNG.reset()
        let resulted = ColorType.randomWhiteAndAlpha(using: &mockRNG)

        XCTAssertTrue(resulted == expected,
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_whiteAlphaComponents_invalid_input() {
        // Doesn't seem ever to fail...
    }

    func test_whiteAlphaComponents() {

        let w = UInt32(UInt8.random(in: 0 ... .max))
        let a = UInt32(UInt8.random(in: 0 ... .max))

        let fw = CGFloat(w) / 255
        let fa = CGFloat(a) / 255

        let expected = ColorType.WhiteAlphaComponents(white: fw, alpha: fa)
        let resulted = ColorType(white: fw, alpha: fa).whiteAlphaComponents()

        XCTAssertTrue(resulted == .success(expected),
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_quadraticLuma_red_green_blue() {

        let r = CGFloat.random01()
        let g = CGFloat.random01()
        let b = CGFloat.random01()

        let rsq = r * r
        let gsq = g * g
        let bsq = b * b

        let expected = 0.2126 * rsq + 0.7152 * gsq + 0.0722 * bsq
        let resulted = ColorType.quadraticLuma(red: r, green: g, blue: b)

        XCTAssertTrue(resulted == expected,
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_quadraticLuma() {

        let r = CGFloat.random01()
        let g = CGFloat.random01()
        let b = CGFloat.random01()
        let a = CGFloat.random01()

        let rsq = r * r
        let gsq = g * g
        let bsq = b * b

        let expected = 0.2126 * rsq + 0.7152 * gsq + 0.0722 * bsq
        let color = ColorType(red: r, green: g, blue: b, alpha: a)

        let resulted = color.quadraticLuma()

        XCTAssertTrue(resulted == .success(expected),
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_contrastingColor_continuous_true_sameAlpha_true() {

        let color = ColorType(red: 0.2, green: 0.7, blue: 0.46, alpha: 0.63)
        let resulted = color.contrastingColor(continuous: true, threshold: 0.5, sameAlpha: true)
        let expected = ColorType(white: 0.6257704800000001, alpha: 0.63)

        XCTAssertTrue(resulted == .success(expected),
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_contrastingColor_continuous_true_sameAlpha_false() {

        let color = ColorType(red: 0.2, green: 0.7, blue: 0.46, alpha: 0.63)
        let resulted = color.contrastingColor(continuous: true, threshold: 0.5, sameAlpha: false)
        let expected = ColorType(white: 0.6257704800000001, alpha: 1)

        XCTAssertTrue(resulted == .success(expected),
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_contrastingColor_continuous_false_sameAlpha_true() {

        let color = ColorType(red: 0.2, green: 0.7, blue: 0.46, alpha: 0.63)
        let resulted = color.contrastingColor(continuous: false, threshold: 0.5, sameAlpha: true)
        let expected = ColorType(white: 1, alpha: 0.63)

        XCTAssertTrue(resulted == .success(expected),
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_contrastingColor_continuous_false_sameAlpha_false() {

        let color = ColorType(red: 0.2, green: 0.7, blue: 0.46, alpha: 0.63)
        let resulted = color.contrastingColor(continuous: false, threshold: 0.5, sameAlpha: false)
        let expected = ColorType(white: 1, alpha: 1)

        XCTAssertTrue(resulted == .success(expected),
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

    func test_contrastingColor_continuous_false_luma_above_threshold() {

        let color = ColorType(red: 0.2, green: 0.7, blue: 0.46, alpha: 0.63)
        let resulted = color.contrastingColor(continuous: false, threshold: 0.1, sameAlpha: false)
        let expected = ColorType(white: 0, alpha: 1)

        XCTAssertTrue(resulted == .success(expected),
                      "exp = \(String(describing: expected)), res = \(String(describing: resulted))")

    }

}

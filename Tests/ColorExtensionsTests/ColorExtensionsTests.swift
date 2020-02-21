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

    //    func test_randomRGBA() {
    //
    //        mockRNG.advance()
    //        let r = mockRNG.nextCGFloat()
    //
    //        mockRNG.advance()
    //        let g = mockRNG.nextCGFloat()
    //
    //        mockRNG.advance()
    //        let b = mockRNG.nextCGFloat()
    //
    //        mockRNG.advance()
    //        let a = mockRNG.nextCGFloat()
    //
    //        let expected = ColorType(red: r, green: g, blue: b, alpha: a)
    //
    //        mockRNG.reset()
    //        let resulted = ColorType.randomRGBA(using: &mockRNG)
    //
    //        XCTAssertTrue(resulted == expected)
    //
    //    }
    //
    //    func test_randomRGB_custom_alpha() {
    //
    //        mockRNG.advance()
    //        let r = mockRNG.nextCGFloat()
    //
    //        mockRNG.advance()
    //        let g = mockRNG.nextCGFloat()
    //
    //        mockRNG.advance()
    //        let b = mockRNG.nextCGFloat()
    //
    //        let a_original = CGFloat.random(in: -0.5 ... 1.5)
    //        let a_clamped = min(max(0, a_original), 1)
    //
    //        let expected = ColorType(red: r, green: g, blue: b, alpha: a_clamped)
    //
    //        mockRNG.reset()
    //        let resulted = ColorType.randomRGB(alpha: a_original, using: &mockRNG)
    //
    //        XCTAssertTrue(resulted == expected)
    //
    //    }
    //
    //    func test_randomRGB_default_alpha() {
    //
    //        mockRNG.advance()
    //        let r = mockRNG.nextCGFloat()
    //
    //        mockRNG.advance()
    //        let g = mockRNG.nextCGFloat()
    //
    //        mockRNG.advance()
    //        let b = mockRNG.nextCGFloat()
    //
    //        let expected = ColorType(red: r, green: g, blue: b, alpha: 1)
    //
    //        mockRNG.reset()
    //        let resulted = ColorType.randomRGB(using: &mockRNG)
    //
    //        XCTAssertTrue(resulted == expected)
    //
    //    }

    func test_init_hexValueRGBA() {
        //            let hexInt = Int(hexValueRGBA)
        //            let r = CGFloat((hexInt & 0xFF000000) >> 24) / 255
        //            let g = CGFloat((hexInt & 0x00FF0000) >> 16) / 255
        //            let b = CGFloat((hexInt & 0x0000FF00) >>  8) / 255
        //            let a = CGFloat((hexInt & 0x000000FF) >>  0) / 255
        //            self.init(red: r, green: g, blue: b, alpha: a)
    }

    func test_init_hexValueRGB_alpha() {
        //            guard hexValueRGB <= 0xFFFFFF else { return nil }
        //            let hexInt = Int(hexValueRGB)
        //            let r = CGFloat((hexInt & 0xFF0000) >> 16) / 255
        //            let g = CGFloat((hexInt & 0x00FF00) >>  8) / 255
        //            let b = CGFloat((hexInt & 0x0000FF) >>  0) / 255
        //            let a = min(max(0, alpha), 1)
        //            self.init(red: r, green: g, blue: b, alpha: a)
    }

    func test_init_hexStringRGBA() {
        //            var hexInt32: UInt32 = 0
        //            let scanner = Scanner(string: hexStringRGBA)
        //            scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        //            let success = scanner.scanHexInt32(&hexInt32)
        //            guard success else { return nil }
        //            self.init(hexValueRGBA: hexInt32)
    }

    func test_init_hexStringRGB_alpha() {
        //            var hexInt32: UInt32 = 0
        //            let scanner = Scanner(string: hexStringRGB)
        //            scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        //            let success = scanner.scanHexInt32(&hexInt32)
        //            guard success else { return nil }
        //            self.init(hexValueRGB: hexInt32, alpha: alpha)
    }

    func test_hexStringRGB() {
        //            rgbaComponents()
        //                .map { comps in
        //                    [comps.red, comps.green, comps.blue]
        //                        .map { Int(255 * $0) }
        //                        .map { String(format:"%02X", $0) }
        //                        .reduce("#", +)
        //                }
    }

    func test_hexStringRGBA() {
        //            rgbaComponents()
        //                .map { comps in
        //                    [comps.red, comps.green, comps.blue, comps.alpha]
        //                        .map { Int(255 * $0) }
        //                        .map { String(format:"%02X", $0) }
        //                        .reduce("#", +)
        //                }
    }

    func test_randomDisplayP3_alpha() {
        //            var rng = SystemRandomNumberGenerator()
        //            return ColorType.randomDisplayP3(alpha: alpha, using: &rng)
    }

    func test_randomDisplayP3A() {
        //            var rng = SystemRandomNumberGenerator()
        //            return ColorType.randomDisplayP3A(using: &rng)
    }

    func test_randomDisplayP3_alpha_rng() {
        //            let r = CGFloat.random01(using: &rng)
        //            let g = CGFloat.random01(using: &rng)
        //            let b = CGFloat.random01(using: &rng)
        //            let a = min(max(0, alpha), 1)
        //            return ColorType(displayP3Red: r, green: g, blue: b, alpha: a)
    }

    func test_randomDisplayP3A_rng() {
        //            let r = CGFloat.random01(using: &rng)
        //            let g = CGFloat.random01(using: &rng)
        //            let b = CGFloat.random01(using: &rng)
        //            let a = CGFloat.random01(using: &rng)
        //            return ColorType(displayP3Red: r, green: g, blue: b, alpha: a)
    }

    func test_randomRGB_alpha() {
        //            var rng = SystemRandomNumberGenerator()
        //            return ColorType.randomRGB(alpha: alpha, using: &rng)
    }

    func test_randomRGBA() {
        //            var rng = SystemRandomNumberGenerator()
        //            return ColorType.randomRGBA(using: &rng)
    }

    func test_randomRGB_alpha_rng() {
        //            let r = CGFloat.random01(using: &rng)
        //            let g = CGFloat.random01(using: &rng)
        //            let b = CGFloat.random01(using: &rng)
        //            let a = min(max(0, alpha), 1)
        //            return ColorType(red: r, green: g, blue: b, alpha: a)
    }

    func test_randomRGBA_rng() {
    }

    func test_rgbaComponents() {
        //            var r: CGFloat = 0
        //            var g: CGFloat = 0
        //            var b: CGFloat = 0
        //            var a: CGFloat = 0
        //            let success = getRed(&r, green: &g, blue: &b, alpha: &a)
        //            guard success else { return .failure(.incompatibleColorSpace) }
        //            return .success(RGBAComponents(red: r, green: g, blue: b, alpha: a))
    }

    func test_randomHSB_alpha() {
        //            var rng = SystemRandomNumberGenerator()
        //            return ColorType.randomHSB(alpha: alpha, using: &rng)
    }

    func test_randomHSBA() {
        //            var rng = SystemRandomNumberGenerator()
        //            return ColorType.randomHSBA(using: &rng)
    }

    func test_randomHSB_alpha_rng() {
        //            let h = CGFloat.random01(using: &rng)
        //            let s = CGFloat.random01(using: &rng)
        //            let b = CGFloat.random01(using: &rng)
        //            let a = min(max(0, alpha), 1)
        //            return ColorType(hue: h, saturation: s, brightness: b, alpha: a)
    }

    func test_randomHSBA_rng() {
        //            let h = CGFloat.random01(using: &rng)
        //            let s = CGFloat.random01(using: &rng)
        //            let b = CGFloat.random01(using: &rng)
        //            let a = CGFloat.random01(using: &rng)
        //            return ColorType(hue: h, saturation: s, brightness: b, alpha: a)
    }

    func test_hsbaComponents() {
        //            var h: CGFloat = 0
        //            var s: CGFloat = 0
        //            var b: CGFloat = 0
        //            var a: CGFloat = 0
        //            let success = getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        //            guard success else { return .failure(.incompatibleColorSpace) }
        //            return .success(HSBAComponents(hue: h, saturation: s, brightness: b, alpha: a))
    }

    func test_randomWhite_alpha() {
        //            var rng = SystemRandomNumberGenerator()
        //            return ColorType.randomWhite(alpha: alpha, using: &rng)
    }

    func test_randomWhiteAndAlpha() {
        //            var rng = SystemRandomNumberGenerator()
        //            return ColorType.randomWhiteAndAlpha(using: &rng)
    }

    func test_randomWhite_alpha_rng() {
        //            let w = CGFloat.random01(using: &rng)
        //            let a = min(max(0, alpha), 1)
        //            return ColorType(white: w, alpha: a)
    }

    func test_randomWhiteAndAlpha_rng() {
        //            let w = CGFloat.random01(using: &rng)
        //            let a = CGFloat.random01(using: &rng)
        //            return ColorType(white: w, alpha: a)
    }

    func test_whiteAlphaComponents() {
        //            var w: CGFloat = 0
        //            var a: CGFloat = 0
        //            let success = getWhite(&w, alpha: &a)
        //            guard success else { return .failure(.incompatibleColorSpace) }
        //            return .success(WhiteAlphaComponents(white: w, alpha: a))
    }

    func test_quadraticLuma_red_green_blue() {
        //            let r = min(max(0, red), 1)
        //            let g = min(max(0, green), 1)
        //            let b = min(max(0, blue), 1)
        //            let rsq = r * r
        //            let gsq = g * g
        //            let bsq = b * b
        //            return (0.2126 * rsq + 0.7152 * gsq + 0.0722 * bsq)
    }

    func test_quadraticLuma() {
        //            rgbaComponents()
        //                .map { comps in
        //                    ColorType.quadraticLuma(red: comps.red, green: comps.green, blue: comps.blue)
        //                }
    }

    func test_contrastingColor_continuous_threshold_sameAlpha() {
        //            rgbaComponents()
        //                .map { comps in
        //                    let luma = ColorType.quadraticLuma(red: comps.red, green: comps.green, blue: comps.blue)
        //                    let a: CGFloat = (sameAlpha ? comps.alpha : 1)
        //                    if continuous {
        //                        return ColorType(white: 1 - luma, alpha: a)
        //                    } else {
        //                        return luma > threshold
        //                            ? ColorType.black.withAlphaComponent(a)
        //                            : ColorType.white.withAlphaComponent(a)
        //                    }
        //                }
    }

}

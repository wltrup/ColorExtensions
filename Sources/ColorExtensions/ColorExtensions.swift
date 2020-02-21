import Foundation

// Todo: Add support for AppKit's NSColor on macOS

import UIKit
public typealias ColorType = UIColor

// MARK: -

extension CGFloat {

    internal static func random01 <RNG: RandomNumberGenerator> (using rng: inout RNG) -> CGFloat {
        CGFloat.random(in: 0 ... 1, using: &rng)
    }

}

// MARK: -

extension ColorType {

    public enum ColorSpaceError: Error {
        case incompatibleColorSpace
    }

}

// MARK: - HEX

extension ColorType {

    /// Creates an instance of `UIColor` (on iOS) or of `NSColor` (on macOS) in the **RGB** color space,
    /// given its hexadecimal representation (which **does** includes alpha).
    ///
    public convenience init(hexValueRGBA: UInt32) {
        let hexInt = Int(hexValueRGBA)
        let r = CGFloat((hexInt & 0xFF000000) >> 24) / 255
        let g = CGFloat((hexInt & 0x00FF0000) >> 16) / 255
        let b = CGFloat((hexInt & 0x0000FF00) >>  8) / 255
        let a = CGFloat((hexInt & 0x000000FF) >>  0) / 255
        self.init(red: r, green: g, blue: b, alpha: a)
    }

    /// Creates an instance of `UIColor` (on iOS) or of `NSColor` (on macOS) in the **RGB** color space,
    /// given its hexadecimal representation (which does **not** include alpha), if valid.
    ///
    public convenience init?(hexValueRGB: UInt32, alpha: CGFloat = 1.0) {
        guard hexValueRGB <= 0xFFFFFF else { return nil }
        let hexInt = Int(hexValueRGB)
        let r = CGFloat((hexInt & 0xFF0000) >> 16) / 255
        let g = CGFloat((hexInt & 0x00FF00) >>  8) / 255
        let b = CGFloat((hexInt & 0x0000FF) >>  0) / 255
        let a = min(max(0, alpha), 1)
        self.init(red: r, green: g, blue: b, alpha: a)
    }

    /// Creates an instance of `UIColor` (on iOS) or of `NSColor` (on macOS) in the **RGB** color space,
    /// given its hexadecimal string representation (which **does** includes alpha).
    ///
    public convenience init?(hexStringRGBA: String) {
        var hexInt32: UInt32 = 0
        let scanner = Scanner(string: hexStringRGBA)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        let success = scanner.scanHexInt32(&hexInt32)
        guard success else { return nil }
        self.init(hexValueRGBA: hexInt32)
    }

    /// Creates an instance of `UIColor` (on iOS) or of `NSColor` (on macOS) in the **RGB** color space,
    /// given its hexadecimal string representation (which does **not** include alpha), if valid.
    ///
    public convenience init?(hexStringRGB: String, alpha: CGFloat = 1.0) {
        var hexInt32: UInt32 = 0
        let scanner = Scanner(string: hexStringRGB)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        let success = scanner.scanHexInt32(&hexInt32)
        guard success else { return nil }
        self.init(hexValueRGB: hexInt32, alpha: alpha)
    }

    /// Returns the hexadecimal representation of `self`, as a string, **without including** the alpha value,
    /// if `self` is represented internally in a **RGB**-compatible color scheme, or the error value
    /// `ColorSpaceError.incompatibleColorSpace` if not.
    ///
    public func hexStringRGB() -> Result<String, ColorSpaceError> {
        rgbaComponents()
            .map { comps in
                [comps.red, comps.green, comps.blue]
                    .map { Int(255 * $0) }
                    .map { String(format:"%02X", $0) }
                    .reduce("#", +)
            }
    }

    /// Returns the hexadecimal representation of `self`, as a string, **including** the alpha value,
    /// if `self` is represented internally in a **RGB**-compatible color scheme, or the error value
    /// `ColorSpaceError.incompatibleColorSpace` if not.
    ///
    public func hexStringRGBA() -> Result<String, ColorSpaceError> {
        rgbaComponents()
            .map { comps in
                [comps.red, comps.green, comps.blue, comps.alpha]
                    .map { Int(255 * $0) }
                    .map { String(format:"%02X", $0) }
                    .reduce("#", +)
            }
    }

}

// MARK: - Display P3

extension ColorType {

    /// Returns a new instance of `UIColor` (on iOS) or of `NSColor` (on macOS) in the **Display P3**
    /// color space, with random values for its color coordinates (red, green, blue), but with its opacity
    /// (alpha) set to the argument passed in (whose default value is 1).
    ///
    public static func randomDisplayP3(alpha: CGFloat = 1) -> ColorType {
        var rng = SystemRandomNumberGenerator()
        return ColorType.randomDisplayP3(alpha: alpha, using: &rng)
    }

    /// Returns a new instance of `UIColor` (on iOS) or of `NSColor` (on macOS) in the **Display P3**
    /// color space, with random values for all of its color coordinates (red, green, blue, alpha).
    ///
    public static func randomDisplayP3A() -> ColorType {
        var rng = SystemRandomNumberGenerator()
        return ColorType.randomDisplayP3A(using: &rng)
    }

    /// Returns a new instance of `UIColor` (on iOS) or of `NSColor` (on macOS) in the **Display P3**
    /// color space, with random values for its color coordinates (red, green, blue), but with its opacity
    /// (alpha) set to the argument passed in (whose default value is 1), and using a particular random
    /// number generator.
    ///
    public static func randomDisplayP3 <RNG: RandomNumberGenerator> (
        alpha: CGFloat = 1,
        using rng: inout RNG
    ) -> ColorType {
        let r = CGFloat.random01(using: &rng)
        let g = CGFloat.random01(using: &rng)
        let b = CGFloat.random01(using: &rng)
        let a = min(max(0, alpha), 1)
        return ColorType(displayP3Red: r, green: g, blue: b, alpha: a)
    }

    /// Returns a new instance of `UIColor` (on iOS) or of `NSColor` (on macOS) in the **Display P3**
    /// color space, with random values for all of its color coordinates (red, green, blue, alpha), using
    /// a particular random number generator.
    ///
    public static func randomDisplayP3A <RNG: RandomNumberGenerator> (using rng: inout RNG) -> ColorType {
        let r = CGFloat.random01(using: &rng)
        let g = CGFloat.random01(using: &rng)
        let b = CGFloat.random01(using: &rng)
        let a = CGFloat.random01(using: &rng)
        return ColorType(displayP3Red: r, green: g, blue: b, alpha: a)
    }

}

// MARK: - RGBA

extension ColorType {

    /// Returns a new instance of `UIColor` (on iOS) or of `NSColor` (on macOS) in the **RGB** color space,
    /// with random values for its color coordinates (red, green, blue), but with its opacity (alpha) set to
    /// the argument passed in (whose default value is 1).
    ///
    public static func randomRGB(alpha: CGFloat = 1) -> ColorType {
        var rng = SystemRandomNumberGenerator()
        return ColorType.randomRGB(alpha: alpha, using: &rng)
    }

    /// Returns a new instance of `UIColor` (on iOS) or of `NSColor` (on macOS) in the **RGB** color space,
    /// with random values for all of its color coordinates (red, green, blue, alpha).
    ///
    public static func randomRGBA() -> ColorType {
        var rng = SystemRandomNumberGenerator()
        return ColorType.randomRGBA(using: &rng)
    }

    /// Returns a new instance of `UIColor` (on iOS) or of `NSColor` (on macOS) in the **RGB** color space,
    /// with random values for its color coordinates (red, green, blue), but with its opacity (alpha)
    /// set to the argument passed in (whose default value is 1), and using a particular random number
    /// generator.
    ///
    public static func randomRGB <RNG: RandomNumberGenerator> (
        alpha: CGFloat = 1,
        using rng: inout RNG
    ) -> ColorType {
        let r = CGFloat.random01(using: &rng)
        let g = CGFloat.random01(using: &rng)
        let b = CGFloat.random01(using: &rng)
        let a = min(max(0, alpha), 1)
        return ColorType(red: r, green: g, blue: b, alpha: a)
    }

    /// Returns a new instance of `UIColor` (on iOS) or of `NSColor` (on macOS) in the **RGB** color space,
    /// with random values for all of its color coordinates (red, green, blue, alpha), using a particular
    /// random number generator.
    ///
    public static func randomRGBA <RNG: RandomNumberGenerator> (using rng: inout RNG) -> ColorType {
        let r = CGFloat.random01(using: &rng)
        let g = CGFloat.random01(using: &rng)
        let b = CGFloat.random01(using: &rng)
        let a = CGFloat.random01(using: &rng)
        return ColorType(red: r, green: g, blue: b, alpha: a)
    }

    public struct RGBAComponents {
        public let red: CGFloat
        public let green: CGFloat
        public let blue: CGFloat
        public let alpha: CGFloat
    }

    /// Returns the RGBA components of `self`, if `self` is represented internally in a **RGB**-compatible
    /// color scheme, or the error value `ColorSpaceError.incompatibleColorSpace` if not.
    ///
    public func rgbaComponents() -> Result<RGBAComponents, ColorSpaceError> {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        let success = getRed(&r, green: &g, blue: &b, alpha: &a)
        guard success else { return .failure(.incompatibleColorSpace) }
        return .success(RGBAComponents(red: r, green: g, blue: b, alpha: a))
    }

}

// MARK: - HSBA

extension ColorType {

    /// Returns a new instance of `UIColor` (on iOS) or of `NSColor` (on macOS) in the **HSB** color space,
    /// with random values for its color coordinates (hue, saturation, brightness), but with its opacity
    /// (alpha) set to the argument passed in (whose default value is 1).
    ///
    public static func randomHSB(alpha: CGFloat = 1) -> ColorType {
        var rng = SystemRandomNumberGenerator()
        return ColorType.randomHSB(alpha: alpha, using: &rng)
    }

    /// Returns a new instance of `UIColor` (on iOS) or of `NSColor` (on macOS) in the **HSB** color space,
    /// with random values for all of its color coordinates (hue, saturation, brightness, alpha).
    ///
    public static func randomHSBA() -> ColorType {
        var rng = SystemRandomNumberGenerator()
        return ColorType.randomHSBA(using: &rng)
    }

    /// Returns a new instance of `UIColor` (on iOS) or of `NSColor` (on macOS) in the **HSB** color space,
    /// with random values for its color coordinates (hue, saturation, brightness), but with its opacity
    /// (alpha) set to the argument passed in (whose default value is 1), and using a particular random
    /// number generator.
    ///
    public static func randomHSB <RNG: RandomNumberGenerator> (
        alpha: CGFloat = 1,
        using rng: inout RNG
    ) -> ColorType {
        let h = CGFloat.random01(using: &rng)
        let s = CGFloat.random01(using: &rng)
        let b = CGFloat.random01(using: &rng)
        let a = min(max(0, alpha), 1)
        return ColorType(hue: h, saturation: s, brightness: b, alpha: a)
    }

    /// Returns a new instance of `UIColor` (on iOS) or of `NSColor` (on macOS) in the **HSB** color space,
    /// with random values for all of its color coordinates (hue, saturation, brightness, alpha), using a
    /// particular random number generator.
    ///
    public static func randomHSBA <RNG: RandomNumberGenerator> (using rng: inout RNG) -> ColorType {
        let h = CGFloat.random01(using: &rng)
        let s = CGFloat.random01(using: &rng)
        let b = CGFloat.random01(using: &rng)
        let a = CGFloat.random01(using: &rng)
        return ColorType(hue: h, saturation: s, brightness: b, alpha: a)
    }

    public struct HSBAComponents {
        public let hue: CGFloat
        public let saturation: CGFloat
        public let brightness: CGFloat
        public let alpha: CGFloat
    }

    /// Returns the HSBA components of `self`, if `self` is represented internally in a **HSB**-compatible
    /// color scheme, or the error value `ColorSpaceError.incompatibleColorSpace` if not.
    ///
    public func hsbaComponents() -> Result<HSBAComponents, ColorSpaceError> {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        let success = getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        guard success else { return .failure(.incompatibleColorSpace) }
        return .success(HSBAComponents(hue: h, saturation: s, brightness: b, alpha: a))
    }

}

// MARK: - White, Alpha

extension ColorType {

    /// Returns a new instance of `UIColor` (on iOS) or of `NSColor` (on macOS) in the **Grayscale** color
    /// space, with random values for its white color coordinate, but with its opacity (alpha) set to the
    /// argument passed in (whose default value is 1).
    ///
    public static func randomWhite(alpha: CGFloat = 1) -> ColorType {
        var rng = SystemRandomNumberGenerator()
        return ColorType.randomWhite(alpha: alpha, using: &rng)
    }

    /// Returns a new instance of `UIColor` (on iOS) or of `NSColor` (on macOS) in the **Grayscale** color
    /// space, with random values for both of its color coordinates (white, alpha).
    ///
    public static func randomWhiteAndAlpha() -> ColorType {
        var rng = SystemRandomNumberGenerator()
        return ColorType.randomWhiteAndAlpha(using: &rng)
    }

    /// Returns a new instance of `UIColor` (on iOS) or of `NSColor` (on macOS) in the **Grayscale** color
    /// space, with random values for its white color coordinate, but with its opacity (alpha) set to the
    /// argument passed in (whose default value is 1), and using a particular random number generator.
    ///
    public static func randomWhite <RNG: RandomNumberGenerator> (
        alpha: CGFloat = 1,
        using rng: inout RNG
    ) -> ColorType {
        let w = CGFloat.random01(using: &rng)
        let a = min(max(0, alpha), 1)
        return ColorType(white: w, alpha: a)
    }

    /// Returns a new instance of `UIColor` (on iOS) or of `NSColor` (on macOS) in the **Grayscale** color
    /// space, with random values for both of its color coordinates (white, alpha), using a particular random
    /// number generator.
    ///
    public static func randomWhiteAndAlpha <RNG: RandomNumberGenerator> (using rng: inout RNG) -> ColorType {
        let w = CGFloat.random01(using: &rng)
        let a = CGFloat.random01(using: &rng)
        return ColorType(white: w, alpha: a)
    }

    public struct WhiteAlphaComponents {
        public let white: CGFloat
        public let alpha: CGFloat
    }

    /// Returns the white and alpha components of `self`, if `self` is represented internally in a
    /// **Grayscale**-compatible color scheme, or the error value `ColorSpaceError.incompatibleColorSpace`
    /// if not.
    ///
    public func whiteAlphaComponents() -> Result<WhiteAlphaComponents, ColorSpaceError> {
        var w: CGFloat = 0
        var a: CGFloat = 0
        let success = getWhite(&w, alpha: &a)
        guard success else { return .failure(.incompatibleColorSpace) }
        return .success(WhiteAlphaComponents(white: w, alpha: a))
    }

}

// MARK: - Luminance

extension ColorType {

    /// Returns an approximate value for the **luminance** of an RGB color,
    /// based on the quadratic expression:
    ///
    /// `L = 0.2126 * red * red + 0.7152 * green * green + 0.0722 * blue * blue`
    ///
    /// where `(red, green, blue)` and `L` are all in the range `[0, 1]`.
    ///
    /// See:
    /// http://gamedev.stackexchange.com/questions/38536/given-a-rgb-color-x-how-to-find-the-most-contrasting-color-y
    ///
    /// - Parameters:
    ///   - red:   the red   component of `self`, in the range [0,1].
    ///   - green: the green component of `self`, in the range [0,1].
    ///   - blue:  the blue  component of `self`, in the range [0,1].
    ///
    /// - Returns: an approximate value for the **luminance** of a color with the given RGB values.
    ///
    public static func quadraticLuma(red: CGFloat, green: CGFloat, blue: CGFloat) -> CGFloat {
        let r = min(max(0, red), 1)
        let g = min(max(0, green), 1)
        let b = min(max(0, blue), 1)
        let rsq = r * r
        let gsq = g * g
        let bsq = b * b
        return (0.2126 * rsq + 0.7152 * gsq + 0.0722 * bsq)
    }

    /// Returns an approximate value for the **luminance** of an RGB color,
    /// based on the quadratic expression:
    ///
    /// `L = 0.2126 * red * red + 0.7152 * green * green + 0.0722 * blue * blue`
    ///
    /// where `(red, green, blue)` and `L` are all in the range `[0, 1]`.
    ///
    /// See:
    /// http://gamedev.stackexchange.com/questions/38536/given-a-rgb-color-x-how-to-find-the-most-contrasting-color-y
    ///
    /// - Returns: an approximate value for the **luminance** of `self`.
    ///
    public func quadraticLuma() -> Result<CGFloat, ColorSpaceError> {
        rgbaComponents()
            .map { comps in
                ColorType.quadraticLuma(red: comps.red, green: comps.green, blue: comps.blue)
            }
    }

}

// MARK: - Contrast

extension ColorType {

    /// Returns a color that contrasts well with `self`.
    ///
    /// See:
    /// http://gamedev.stackexchange.com/questions/38536/given-a-rgb-color-x-how-to-find-the-most-contrasting-color-y
    ///
    /// - Parameters:
    ///
    ///   - continuous: when `true`, the resulting color is some shade of gray ranging
    ///                 from white to black; when `false`, the resulting color is either
    ///                 white or black, depending on a luminance threshold. The default
    ///                 behaviour is to result in a continuous shade of gray.
    ///
    ///   - threshold: ignored when `continuous` is set to `true`, otherwise used to
    ///                decide whether the resulting color is white or black. The result
    ///                is black when `self` has a luminance larger than this threshold,
    ///                else the result if white. The default threshold value is 0.2.
    ///
    ///   - sameAlpha: when `true`, the resulting color has the same `alpha` component
    ///                as `self`, otherwise it has `alpha` equal to 1. The default is
    ///                `false` so the resulting color has `alpha` equal to 1.
    ///
    /// - Returns: a color that contrasts well with `self`.
    ///
    public func contrastingColor(
        continuous: Bool = true,
        threshold: CGFloat = 0.2,
        sameAlpha: Bool = false
    ) -> Result<ColorType, ColorSpaceError> {
        rgbaComponents()
            .map { comps in
                let luma = ColorType.quadraticLuma(red: comps.red, green: comps.green, blue: comps.blue)
                let a: CGFloat = (sameAlpha ? comps.alpha : 1)
                if continuous {
                    return ColorType(white: 1 - luma, alpha: a)
                } else {
                    return luma > threshold
                        ? ColorType.black.withAlphaComponent(a)
                        : ColorType.white.withAlphaComponent(a)
                }
            }
    }

}

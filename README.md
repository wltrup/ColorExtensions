# ColorExtensions

## What

**ColorExtensions** is a Swift Package Manager package for iOS, iPadOS, and watchOS providing a variety of useful extensions to UIColor. In fact, here's a complete list of all the functions and extra types that are made available by this package:
```swift
extension UIColor {

    public enum ColorSpaceError: Error {
        case incompatibleColorSpace
    }

    public struct RGBAComponents: Equatable {
        public let red: CGFloat
        public let green: CGFloat
        public let blue: CGFloat
        public let alpha: CGFloat
    }

    public struct HSBAComponents: Equatable {
        public let hue: CGFloat
        public let saturation: CGFloat
        public let brightness: CGFloat
        public let alpha: CGFloat
    }

    public struct WhiteAlphaComponents: Equatable {
        public let white: CGFloat
        public let alpha: CGFloat
    }

    // MARK: - HEX

    /// Creates an instance of UIColor in the RGB color space, given its
    /// hexadecimal representation (which does include alpha).
    ///
    public convenience init(hexValueRGBA: UInt32)

    /// Creates an instance of UIColor in the RGB color space, given its
    /// hexadecimal representation (which does not include alpha), if valid.
    ///
    public convenience init?(hexValueRGB: UInt32, alpha: CGFloat = 1.0)

    /// Creates an instance of UIColor in the RGB color space, given its
    /// hexadecimal string representation (which does include alpha).
    ///
    public convenience init?(hexStringRGBA: String)

    /// Creates an instance of UIColor in the RGB color space, given its
    /// hexadecimal string representation (which does not include alpha), if
    /// valid.
    ///
    public convenience init?(hexStringRGB: String, alpha: CGFloat = 1.0)

    /// Returns the hexadecimal representation of self, as a string, without
    /// including the alpha value, if self is represented internally in a
    /// RGB-compatible color scheme, or the error value
    /// ColorSpaceError.incompatibleColorSpace if not.
    ///
    public func hexStringRGB() -> Result<String, ColorSpaceError>

    /// Returns the hexadecimal representation of self, as a string, including
    /// the alpha value, if self is represented internally in a RGB-compatible
    /// color scheme, or the error value ColorSpaceError.incompatibleColorSpace
    /// if not.
    ///
    public func hexStringRGBA() -> Result<String, ColorSpaceError>

    // MARK: - Display P3

    /// Returns a new instance of UIColor in the Display P3 color space, with
    /// random values for its color coordinates (red, green, blue), but with
    /// its opacity (alpha) set to the argument passed in (whose default value
    /// is 1).
    ///
    public static func randomDisplayP3(alpha: CGFloat = 1) -> UIColor

    /// Returns a new instance of UIColor in the Display P3 color space, with
    /// random values for all of its color coordinates (red, green, blue,
    /// alpha).
    ///
    public static func randomDisplayP3A() -> UIColor

    /// Returns a new instance of UIColor in the Display P3 color space, with
    /// random values for its color coordinates (red, green, blue), but with
    /// its opacity (alpha) set to the argument passed in (whose default value
    /// is 1), and using a particular random number generator.
    ///
    public static func randomDisplayP3 <RNG: RandomNumberGenerator> (
        alpha: CGFloat = 1,
        using rng: inout RNG
    ) -> UIColor

    /// Returns a new instance of UIColor in the Display P3 color space, with
    /// random values for all of its color coordinates (red, green, blue,
    /// alpha), using a particular random number generator.
    ///
    public static func randomDisplayP3A <RNG: RandomNumberGenerator> (
        using rng: inout RNG
    ) -> UIColor

    // MARK: - RGBA

    /// Returns a new instance of UIColor in the RGB color space, with random
    /// values for its color coordinates (red, green, blue), but with its
    /// opacity (alpha) set to the argument passed in (whose default value is
    /// 1).
    ///
    public static func randomRGB(alpha: CGFloat = 1) -> UIColor

    /// Returns a new instance of UIColor in the RGB color space, with random
    /// values for all of its color coordinates (red, green, blue, alpha).
    ///
    public static func randomRGBA() -> UIColor

    /// Returns a new instance of UIColor in the RGB color space, with random
    /// values for its color coordinates (red, green, blue), but with its
    /// opacity (alpha) set to the argument passed in (whose default value is
    /// 1), and using a particular random number generator.
    ///
    public static func randomRGB <RNG: RandomNumberGenerator> (
        alpha: CGFloat = 1,
        using rng: inout RNG
    ) -> UIColor

    /// Returns a new instance of UIColor in the RGB color space, with random
    /// values for all of its color coordinates (red, green, blue, alpha),
    /// using a particular random number generator.
    ///
    public static func randomRGBA <RNG: RandomNumberGenerator> (
        using rng: inout RNG
    ) -> UIColor

    /// Returns the RGBA components of self, if self is represented internally
    /// in a RGB-compatible color scheme, or the error value
    /// ColorSpaceError.incompatibleColorSpace if not.
    ///
    public func rgbaComponents() -> Result<RGBAComponents, ColorSpaceError>

    // MARK: - HSBA

    /// Returns a new instance of UIColor in the HSB color space, with random
    /// values for its color coordinates (hue, saturation, brightness), but
    /// with its opacity (alpha) set to the argument passed in (whose default
    /// value is 1).
    ///
    public static func randomHSB(alpha: CGFloat = 1) -> UIColor

    /// Returns a new instance of UIColor in the HSB color space, with random
    /// values for all of its color coordinates (hue, saturation, brightness,
    /// alpha).
    ///
    public static func randomHSBA() -> UIColor

    /// Returns a new instance of UIColor in the HSB color space, with random
    /// values for its color coordinates (hue, saturation, brightness), but
    /// with its opacity (alpha) set to the argument passed in (whose default
    /// value is 1), and using a particular random number generator.
    ///
    public static func randomHSB <RNG: RandomNumberGenerator> (
        alpha: CGFloat = 1,
        using rng: inout RNG
    ) -> UIColor

    /// Returns a new instance of UIColor in the HSB color space, with random
    /// values for all of its color coordinates (hue, saturation, brightness,
    /// alpha), using a particular random number generator.
    ///
    public static func randomHSBA <RNG: RandomNumberGenerator> (
        using rng: inout RNG
    ) -> UIColor

    /// Returns the HSBA components of self, if self is represented internally
    /// in a HSB-compatible color scheme, or the error value
    /// ColorSpaceError.incompatibleColorSpace if not.
    ///
    public func hsbaComponents() -> Result<HSBAComponents, ColorSpaceError>

    // MARK: - White, Alpha

    /// Returns a new instance of UIColor in the Grayscale color space, with
    /// random values for its white color coordinate, but with its opacity
    /// (alpha) set to the argument passed in (whose default value is 1).
    ///
    public static func randomWhite(alpha: CGFloat = 1) -> UIColor

    /// Returns a new instance of UIColor in the Grayscale color space, with
    /// random values for both of its color coordinates (white, alpha).
    ///
    public static func randomWhiteAndAlpha() -> UIColor

    /// Returns a new instance of UIColor in the Grayscale color space, with
    /// random values for its white color coordinate, but with its opacity
    /// (alpha) set to the argument passed in (whose default value is 1), and
    /// using a particular random number generator.
    ///
    public static func randomWhite <RNG: RandomNumberGenerator> (
        alpha: CGFloat = 1,
        using rng: inout RNG
    ) -> UIColor

    /// Returns a new instance of UIColor in the Grayscale color space, with
    /// random values for both of its color coordinates (white, alpha), using a
    /// particular random number generator.
    ///
    public static func randomWhiteAndAlpha <RNG: RandomNumberGenerator> (
        using rng: inout RNG
    ) -> UIColor

    /// Returns the white and alpha components of self, if self is represented
    /// internally in a Grayscale-compatible color scheme, or the error value
    /// ColorSpaceError.incompatibleColorSpace if not.
    ///
    public func whiteAlphaComponents() -> Result<WhiteAlphaComponents, ColorSpaceError>

    // MARK: - Luminance

    /// Returns an approximate value for the luminance of an RGB color.
    ///
    /// See [this entry](http://gamedev.stackexchange.com/questions/38536/given-a-rgb-color-x-how-to-find-the-most-contrasting-color-y) in gamedev.stackexchange
    ///
    public static func quadraticLuma(red: CGFloat, green: CGFloat, blue: CGFloat) -> CGFloat

    /// Returns an approximate value for the luminance of an RGB color.
    ///
    /// See [this entry](http://gamedev.stackexchange.com/questions/38536/given-a-rgb-color-x-how-to-find-the-most-contrasting-color-y) in gamedev.stackexchange
    ///
    public func quadraticLuma() -> Result<CGFloat, ColorSpaceError>

    // MARK: - Contrast

    /// Returns a color that contrasts well with self.
    ///
    /// See [this entry](http://gamedev.stackexchange.com/questions/38536/given-a-rgb-color-x-how-to-find-the-most-contrasting-color-y) in gamedev.stackexchange
    ///
    /// - Parameters:
    ///
    /// - continuous: when true, the resulting color is some shade of gray
    /// ranging from white to black; when false, the resulting color is either
    /// white or black, depending on a luminance threshold. The default
    /// behaviour is to result in a continuous shade of gray.
    ///
    /// - threshold: ignored when continuous is set to true, otherwise used to
    /// decide whether the resulting color is white or black. The result is
    /// black when self has a luminance larger than this threshold, else the
    /// result if white. The default threshold value is 0.2.
    ///
    /// - sameAlpha: when true, the resulting color has the same alpha
    /// component as self, otherwise it has alpha equal to 1. The default is
    /// false so the resulting color has alpha equal to 1.
    ///
    /// - Returns: a color that contrasts well with self. ///
    ///
    public func contrastingColor(
        continuous: Bool = true,
        threshold: CGFloat = 0.2,
        sameAlpha: Bool = false
    ) -> Result<UIColor, ColorSpaceError>

}
```

## Installation

**ColorExtensions** is provided only as a Swift Package Manager package, because I'm moving away from CocoaPods and Carthage, and can be easily installed directly from Xcode.

## Author

Wagner Truppel, trupwl@gmail.com

## License

**ColorExtensions** is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.

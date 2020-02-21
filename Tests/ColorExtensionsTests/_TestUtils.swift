import Foundation
import CoreGraphics

struct MockRNG: RandomNumberGenerator {

     private var index = 0

     mutating func reset() {
         index = 0
     }

     mutating func advance() {
         index = (index + 1) % 4
     }

    mutating func next() -> UInt64 {
        advance()
        switch index {

        case 0:
            return 0123456789012345678

        case 1:
            return 1234567890012345678

        case 2:
            return 2345678901012345678

        case 3:
            return 3456789012012345678

        default:
            return 0 // shouldn't happen

        }
    }

    func nextCGFloat() -> CGFloat {
        switch index {

        case 0:
            return 0.006692605942763441

        case 1:
            return 0.06692605942161145

        case 2:
            return 0.12715950802154974

        case 3:
            return 0.18739290783239027

        default:
            return 0 // shouldn't happen

        }
    }

}

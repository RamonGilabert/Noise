import UIKit

func noise() {

}

struct Noise {

}

var noiseAmmount: Int = 115

extension UIView {

  func randomNoise() -> Int {
    noiseAmmount = (noiseAmmount * 214013 + 2531011) & ((Int64(1) << 31) - 1)
    return noiseAmmount >> 16
  }

  public func noise() {
    UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0)

    let context = UIGraphicsGetCurrentContext()

    backgroundColor?.setFill()
    CGContextFillRect(context, frame)
    buildNoise()

    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    backgroundColor = UIColor(patternImage: image)
  }

  public func buildNoise() {
    struct Static {
      static var token: dispatch_once_t = 0
      static var reference: CGImage? = nil
    }

    dispatch_once(&Static.token) {
      let width = Int(self.frame.width)
      let height = Int(self.frame.height)
      let size = width * height
      let bitmapData = UnsafeMutablePointer<Character>(malloc(size))

      for i in 0 ..< size {
        bitmapData[i] = Character(UnicodeScalar(self.randomNoise() % 256))
      }

      let colorSpace = CGColorSpaceCreateDeviceGray()
      let bitmapContext = CGBitmapContextCreate(
        bitmapData, width, height, 8, width, colorSpace, CGImageAlphaInfo.None.rawValue)

      Static.reference = CGBitmapContextCreateImage(bitmapContext)

      free(bitmapData)
    }

    let context = UIGraphicsGetCurrentContext()

    CGContextSaveGState(context)
    CGContextSetAlpha(context, 0.2)
    CGContextSetBlendMode(context, .Multiply)
    print(context)
    let frame = CGRect(x: 0, y: 0,
                       width: CGImageGetWidth(Static.reference),
                       height: CGImageGetHeight(Static.reference))
    CGContextDrawTiledImage(context, frame, Static.reference)
    CGContextRestoreGState(context)
  }
}
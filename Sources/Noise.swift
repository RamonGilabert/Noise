import UIKit

func noise() {

}

struct Noise {

}

extension UIView {

  public func noise() {
    let frame = CGRect(origin: CGPointZero, size: CGSize(width: bounds.width, height: bounds.height))
    UIGraphicsBeginImageContextWithOptions(frame.size, true, 0)

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
    }

    var imageReference: CGImage? = nil

    dispatch_once(&Static.token) {
      let width = 128
      let size = width * width
      let bitmapData = UnsafeMutablePointer<CUnsignedChar>(malloc(size))

      srand(124)

      for i in 0 ..< size - 1 {
        let value = Int8(arc4random_uniform(128) % 256)
        bitmapData[i] = CUnsignedChar(bitPattern: Int8(value))
      }

      let colorSpace = CGColorSpaceCreateDeviceGray()
      let bitmapContext = CGBitmapContextCreate(
        bitmapData, width, width, 8, width, colorSpace, CGImageAlphaInfo.None.rawValue)

      imageReference = CGBitmapContextCreateImage(bitmapContext)

      free(bitmapData)
    }

    let context = UIGraphicsGetCurrentContext()

    CGContextSaveGState(context)
    CGContextSetAlpha(context, 0.6)
    CGContextSetBlendMode(context, .Overlay)

    let frame = CGRect(x: 0, y: 0,
                       width: CGImageGetWidth(imageReference),
                       height: CGImageGetHeight(imageReference))
    CGContextDrawTiledImage(context, frame, imageReference)
    CGContextRestoreGState(context)
  }
}
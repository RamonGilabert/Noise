import UIKit

func noise() {

}

struct Noise {

}

extension UIView {

  func randomNoise() -> Int8 {
    return 0
  }

  func noise() {
    struct Static {
      static var token: dispatch_once_t = 0
      static var reference: CGImage? = nil
    }

    dispatch_once(&Static.token) {
      let width = Int(self.frame.width)
      let height = Int(self.frame.height)
      let size = width * height
      let bitmapData = UnsafeMutablePointer<CChar>(bitPattern: size)

      for i in 0 ..< size {
        bitmapData[i] = 25
      }

      let colorSpace = CGColorSpaceCreateDeviceGray()
      let bitmapContext = CGBitmapContextCreate(
        bitmapData, width, height, 8, width, colorSpace, CGImageAlphaInfo.PremultipliedLast.rawValue)

      Static.reference = CGBitmapContextCreateImage(bitmapContext)

      free(bitmapData)

      let context = UIGraphicsGetCurrentContext()

      CGContextSaveGState(context)
      CGContextSetAlpha(context, 0.2)
      CGContextSetBlendMode(context, .Normal)

      let frame = CGRect(x: 0, y: 0,
                         width: CGImageGetWidth(Static.reference),
                         height: CGImageGetHeight(Static.reference))
      CGContextDrawTiledImage(context, frame, Static.reference)
      CGContextRestoreGState(context)
    }
  }
}
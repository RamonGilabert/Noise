import UIKit

/**
 Noise is a function that creates noise to a given view.

 - Parameter view: The view the noise should be applied to.
 - Parameter alpha: The alpha of the noise (defaults to 0.2).
 - Parameter blend: A CGBlendMode that will apply to the view (defaults to Overlay).

 The function returns the same view as is but with a random overlay changing basically the color of the view.
 */
public func noise(view: UIView, alpha: CGFloat = 0.2, blend: CGBlendMode = .Overlay) {

  Noise.background(view, alpha, blend)
}

extension UIView {

  /**
   Noise is a function that creates noise to a given view.

   - Parameter alpha: The alpha of the noise (defaults to 0.2).
   - Parameter blend: A CGBlendMode that will apply to the view (defaults to Overlay).

   The function returns the same view as is but with a random overlay changing basically the color of the view.
   */
  public func noise(alpha alpha: CGFloat = 0.2, blend: CGBlendMode = .Overlay) {
    Noise.background(self, alpha, blend)
  }
}

struct Noise {

  static func background(view: UIView, _ alpha: CGFloat = 0.2, _ blend: CGBlendMode = .Overlay) {
    let frame = view.bounds
    UIGraphicsBeginImageContextWithOptions(frame.size, true, 0)

    let context = UIGraphicsGetCurrentContext()

    view.backgroundColor?.setFill()
    CGContextFillRect(context, frame)
    buildNoise(alpha, blend)

    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    view.backgroundColor = UIColor(patternImage: image)
  }

  static func buildNoise(alpha: CGFloat, _ blend: CGBlendMode = .Overlay) {
    struct Static {
      static var token: dispatch_once_t = 0
    }

    var imageReference: CGImage? = nil

    dispatch_once(&Static.token) {
      let width = 128
      let size = width * width
      let bitmapData = UnsafeMutablePointer<CChar>(malloc(size))

      for i in 0 ..< size {
        let value = arc4random() % 256
        bitmapData[i] = CChar(bitPattern: UInt8(value))
      }

      let colorSpace = CGColorSpaceCreateDeviceGray()
      let bitmapContext = CGBitmapContextCreate(
        bitmapData, width, width, 8, width, colorSpace, CGImageAlphaInfo.None.rawValue)

      imageReference = CGBitmapContextCreateImage(bitmapContext)

      free(bitmapData)
    }

    let context = UIGraphicsGetCurrentContext()

    CGContextSaveGState(context)
    CGContextSetAlpha(context, alpha)
    CGContextSetBlendMode(context, blend)

    let frame = CGRect(x: 0, y: 0,
                       width: CGImageGetWidth(imageReference),
                       height: CGImageGetHeight(imageReference))
    CGContextDrawTiledImage(context, frame, imageReference)
    CGContextRestoreGState(context)
  }
}

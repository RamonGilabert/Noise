import UIKit
import Noise

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = UIColor.whiteColor()

    let totalSize = UIScreen.mainScreen().bounds
    let orange = UIView()
    orange.frame = CGRect(x: (totalSize.width - 150) / 2,
                          y: (totalSize.height - 300) / 2,
                          width: 150, height: 150)
    orange.layer.cornerRadius = 5
    orange.backgroundColor = UIColor.orangeColor()

    view.addSubview(orange)
  }
}

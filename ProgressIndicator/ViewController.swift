import UIKit
import ProgressIndicatorLib
import Spatial

class ViewController: UIViewController {

   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
   }
}
extension ViewController{
   /**
    * ProgressIndicator
    */
   @objc func createProgressIndicator() -> ProgressIndicator{
      //      let frame:CGRect = CGRect.init(origin: .zero, size: CGSize(width:164,height:164))
      let progressIndicator:ProgressIndicator = ProgressIndicator.init()
      container.addSubview(progressIndicator)
      progressIndicator.activateConstraint { view in
         let s = Constraint.size(view, size: CGSize(width:164,height:164))
         return [s.w,s.h]
      }
      return progressIndicator
   }
}

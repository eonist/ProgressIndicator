import UIKit
import ProgressIndicatorLib
import Spatial

class ViewController: UIViewController {
   lazy var progressIndicator:ProgressIndicator = createProgressIndicator()
   override func viewDidLoad() {
      super.viewDidLoad()
      _ = progressIndicator
      progressIndicator.start()
   }
}
/**
 * Create
 */
extension ViewController{
   /**
    * ProgressIndicator
    */
   @objc func createProgressIndicator() -> ProgressIndicator{
      //let frame:CGRect = CGRect.init(origin: .zero, size: CGSize(width:164,height:164))
      let progressIndicator:ProgressIndicator = ProgressIndicator.init()
      self.view.addSubview(progressIndicator)
      progressIndicator.activateConstraints { view in
         let a = Constraint.anchor(view, to: self.view, align: .centerCenter, alignTo: .centerCenter)
         let s = Constraint.size(view, size: CGSize(width:164,height:164))
         return (a,s)
      }
      return progressIndicator
   }
}

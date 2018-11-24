import UIKit
import Chaplin

/**
 * EXAMPLE:
 * let progressIndicator = ProgressIndicator.init()
 * container.addSubview(progressIndicator)
 * progressIndicator.activateConstraint { view in
 *    let s = Constraint.size(view, size: CGSize(width:164,height:164))
 *    return [s.w,s.h]
 * }
 */
class ProgressIndicator:UIView {
   lazy var shapeLayer:CAShapeLayer = createShapeLayer()
   var lineStyle:LineStyle = ProgressIndicator.defaultStyle
   lazy var animator:TimeAnimator = createAnimator()//   lazy var animator:Animator = {LoopingAnimator(AnimProxy.shared,Int.max,1,0,1,self.progress,Linear.ease)}()
   var revealProgress:CGFloat = 0
   /**
    * Note: We relay on getting .frame in the subsequent called methods, as such we need to be mindful when we access it, as its only available after AutoLayout has done its bidding.
    */
   override func layoutSubviews() {
      super.layoutSubviews()
      self.backgroundColor = .lightGray
      createIndicators()
   }
}

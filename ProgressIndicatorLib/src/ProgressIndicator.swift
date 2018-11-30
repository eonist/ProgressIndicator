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
open class ProgressIndicator:UIView {
   open lazy var shapeLayer:CAShapeLayer = createShapeLayer()
   open var lineStyle:LineStyle = ProgressIndicator.defaultStyle
   open lazy var animator:TimeAnimator = createAnimator()//   lazy var animator:Animator = {LoopingAnimator(AnimProxy.shared,Int.max,1,0,1,self.progress,Linear.ease)}()
   open var revealProgress:CGFloat = 0
   public override init(frame: CGRect) {
      super.init(frame: frame)
      self.backgroundColor = .lightGray
   }
   
   required public init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   /**
    * Note: We relay on getting .frame in the subsequent called methods, as such we need to be mindful when we access it, as its only available after AutoLayout has done its bidding.
    */
   override open func layoutSubviews() {
      super.layoutSubviews()
      createIndicators()
   }
}

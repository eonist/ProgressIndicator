import UIKit
import Chaplin
/**
 * Create
 */
extension ProgressIndicator {
   /**
    * Create ShapeLayer
    */
   @objc public func createShapeLayer() -> CAShapeLayer {
      let shapeLayer: CAShapeLayer = .init()
      shapeLayer.backgroundColor = UIColor.clear.cgColor
      self.layer.addSublayer(shapeLayer)
      return shapeLayer
   }
   /**
    * Creates the indicator lines
    */
   @objc public func createIndicators() {
      let center: CGPoint = .init(x: frame.width / 2, y: frame.height / 2) // CGRect(origin:.zero,size:CGSize(frame.width,frame.height))//center of element
      let radius: CGFloat = frame.width / 4 - lineStyle.strokeWidth / 2
      let π = CGFloat(Double.pi)
      let wedge: CGFloat = π * 2 / 12 // Wedge amount
      for i in 0..<12 {
         let angle = wedge * CGFloat(i) - π / 2 // <--minus π/2 so that the start angle is center bottom so to speak
         let startP = center.polarPoint(radius / 2, angle)
         let endP = center.polarPoint(radius, angle)
         let line: CAShapeLayer = CGShapeUtil.drawLine(.init(), line: (startP, endP), style: (lineStyle.strokeColor, lineStyle.strokeWidth))
         shapeLayer.addSublayer(line)
      }
   }
   /**
    * Creates animator
    */
   public func createAnimator() -> TimeAnimator {
      let animator = TimeAnimator(duration: 1.0)
      animator.tick = {
         DispatchQueue.main.async {
            self.progress(animator.progress)
         }
      }
      animator.onComplete = onComplete
      return animator
   }
   /**
    * onComplete
    */
   @objc public func onComplete() {
      self.animator.stop()
      self.animator = createAnimator()
      self.animator.start()
   }
}

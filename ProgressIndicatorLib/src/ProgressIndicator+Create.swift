import UIKit
import Chaplin
/**
 * Create
 */
extension ProgressIndicator {
   /**
    * Create ShapeLayer
    */
   @objc public func createShapeLayer() -> CAShapeLayer{
      let shapeLayer:CAShapeLayer = .init()
      shapeLayer.backgroundColor = UIColor.clear.cgColor
      self.layer.addSublayer(shapeLayer)
      return shapeLayer
   }
   /**
    * Creates the indicator lines
    */
   @objc public func createIndicators() {
      let center:CGPoint = CGPoint(x:frame.width/2, y:frame.height/2)//CGRect(origin:.zero,size:CGSize(frame.width,frame.height))//center of element
      //Swift.print("center: " + "\(center)")
      let radius:CGFloat = frame.width/4 - lineStyle.strokeWidth/2
      //Swift.print("radius: " + "\(radius)")
      let π = CGFloat(Double.pi)
      let wedge:CGFloat = π*2/12//Wedge amount
      for i in 0..<12 {
         let angle = wedge * CGFloat(i) - π/2//<--minus π/2 so that the start angle is center bottom so to speak
         let startP = center.polarPoint(radius/2, angle)
         let endP = center.polarPoint(radius, angle)
         //         let line:LineGraphic = LineGraphic(startP,endP,lineStyle.copy())
         //         self.layer.addSublayer(shapeLayer)
         let line:CAShapeLayer = CGShapeUtil.drawLine(.init(),line:(startP,endP),style:(lineStyle.strokeColor,lineStyle.strokeWidth))
         shapeLayer.addSublayer(line)
         //lines.append(line)
         // _ = addSubView(line.graphic)
         // line.draw()
      }
      
//      for e in 0..<12{//reset all values
//         guard let line:CAShapeLayer = self.shapeLayer.sublayers?[e] as? CAShapeLayer else { fatalError("line doesnt exist")}
//         Swift.print("line:  \(line)")
//         line.strokeColor = line.strokeColor?.copy(alpha: 1)
//      }
   }
   /**
    * Creates animator
    */
   public func createAnimator() -> TimeAnimator{
      let animator = TimeAnimator(duration:1.0)
      animator.tick = {
         //Swift.print("animator.curCount:  \(animator.curCount)")
//         Swift.print("animator.progress:  \(animator.progress)")
         DispatchQueue.main.async {
            self.progress(animator.progress)
         }
         //         self.curX = TimeAnimator.interpolate(from: from, to: to, fraction: animator.progress)
         //         self.frame.origin.x = self.curX
      }
      //animator.start()
      //Looping:
      animator.onComplete = onComplete
      return animator
   }
   /**
    * onComplete
    */
   @objc public func onComplete(){
//      Swift.print("loop again")
      self.animator.stop()
      self.animator = createAnimator()
      self.animator.start()
   }
}

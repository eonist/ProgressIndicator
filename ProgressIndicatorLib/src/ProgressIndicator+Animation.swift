import UIKit
import Chaplin

/**
 * Animation
 */
extension ProgressIndicator {
   /**
    * Modulate the progress indicator (For iterative progress or looping animation)
    * PARAM: value: 0 - 1
    * Fixme: Could the bellow be done simpler: think sequence looping in a video.
    */
   @objc public func progress(_ value: CGFloat) {
      let initAlpha: CGFloat = lineStyle.strokeColor.cgColor.alpha//<--can be moved to a global scope
      let restAlpha = 1 - initAlpha//<--can be moved to a global scope
      for i in 0..<12 { // reset all values
         guard let line: CAShapeLayer = self.shapeLayer.sublayers?[i] as? CAShapeLayer else { fatalError("line doesnt exist") }
         line.strokeColor = line.strokeColor?.copy(alpha: initAlpha)
      }
      let progress: Int = .init(round(12 * value)) // value = 0.25 -> 3, value = 0.5 -> 6 etc etc (values from 0 - 12 )
      for i in 0..<7 {//iterates 7 times
         let alpha: CGFloat = initAlpha + (restAlpha * (1.0 / 7 * CGFloat(i))) // we need a half circle with gradually increasing alpha values starting from initAlpha
         let a: Int = progress + i + 5 // <--offset a half circle by adding 5
         let e: Int = IntParser.normalize(a, 12)//clamps the values between 0 and 12
         guard let line: CAShapeLayer = self.shapeLayer.sublayers?[e] as? CAShapeLayer else { fatalError("line doesnt exist") }
         line.strokeColor = line.strokeColor?.copy(alpha: alpha)
      }
   }
   /**
    * Basically Tick the lines into visibility one by one (from the top one)
    * - NOTE: Reveal one tick at the time from top
    * - NOTE: You also want to set the alpha gradually from half to full alpha in a half circle
    * - Fixme: The final tick should be 0, to make this happen you need to offset the i, possibly
    */
   @objc public func reveal(_ value: CGFloat) {/*value goes from 0 to 1*/
      revealProgress = value
      let initAlpha = lineStyle.strokeColor.cgColor.alpha//<--can be moved to a global scope
      let restAlpha = 1 - initAlpha//<--can be moved to a global scope
      let p: Int = .init(round(12 * value)) //progression from 0 to 12
      for i in 0..<12 {
         var alpha: CGFloat
         if i < p { // integers before p
            if i >= p - 6 && i <= p {//<--Fixme: ⚠️️ use range here
               let relLoc: CGFloat = 7 - CGFloat(p - i)//Figure out where the i is in the range: p-6 until p
               let multiplier: CGFloat = relLoc / 6 // base the relative pos as the multiplier for the alpha level.
               alpha = initAlpha + (restAlpha * multiplier)//max equals 1 alpha, min equals 0.5
            } else {
               alpha = initAlpha
            }
         } else {// integers after p
            alpha = 0
         }
         guard let line: CAShapeLayer = self.shapeLayer.sublayers?[i] as? CAShapeLayer else { fatalError("line doesnt exist") }
         line.strokeColor = line.strokeColor?.copy(alpha: alpha)
      }
   }
}

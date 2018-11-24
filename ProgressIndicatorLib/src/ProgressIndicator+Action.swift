import Foundation

/**
 * Action
 */
public extension ProgressIndicator {
   /**
    * Esentially you start a repeating animation that modulates a value from 0 - 1 of a defined time over n-times
    */
   @objc public func start(){
      //Swift.print("💚 ProgressIndicator.start")
      //assert if animator exist else create animator w/ repeatCount : 0 and 0 to 1 sec w/ progress as the call back method
      //start anim
      //lineStyle.color = lineStyle.color.alpha(0.5)
      animator.stop()//stop any previous running animation
      animator.start()/*start animator*/
   }
   /**
    * Stop
    */
   @objc public func stop(){
      //Swift.print("❤️️ ProgressIndicator.stop")
      animator.stop()/*stop animator*/
   }
}

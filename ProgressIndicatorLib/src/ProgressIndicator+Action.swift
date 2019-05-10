import Foundation
/**
 * Action
 */
extension ProgressIndicator {
   /**
    * Esentially you start a repeating animation that modulates a value from 0 - 1 of a defined time over n-times
    */
   @objc public func start() {
      animator.stop()//stop any previous running animation
      animator.start()/*start animator*/
   }
   /**
    * Stop
    */
   @objc public func stop() {
      animator.stop()/*stop animator*/
   }
}

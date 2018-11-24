import UIKit
import Chaplin

/**
 * Animation
 */
extension ProgressIndicator {
   /**
    * Modulate the progress indicator (For iterative progress or looping animation)
    * PARAM: value: 0 - 1
    */
   func progress(_ value:CGFloat){
//      Swift.print("💙 ProgressIndicator.progress: " + "\(value)")
      //Could the bellow be done simpler: think sequence looping in a video.
      let initAlpha:CGFloat = lineStyle.strokeColor.cgColor.alpha//<--can be moved to a global scope
//      Swift.print("initAlpha:  \(initAlpha)")
      let restAlpha = 1 - initAlpha//<--can be moved to a global scope
//      Swift.print("restAlpha:  \(restAlpha)")
      for i in 0..<12{//reset all values
         guard let line:CAShapeLayer = self.shapeLayer.sublayers?[i] as? CAShapeLayer else { fatalError("line doesnt exist")}
//         Swift.print("line:  \(line)")
         line.strokeColor = line.strokeColor?.copy(alpha: initAlpha)
//         if let line = shapeLayer.sublayers?[i]{
//            line.borderColor = line.borderColor?.copy(alpha: initAlpha)
//         }
      }
      let progress:Int = Int(round(12 * value))//value = 0.25 -> 3, value = 0.5 -> 6 etc etc (values from 0 - 12 )
      for i in 0..<7{//iterates 7 times
         let alpha:CGFloat = initAlpha + (restAlpha * (1.0/7 * CGFloat(i)))//we need a half circle with gradually increasing alpha values starting from initAlpha
         let a:Int = progress + i + 5//<--offset a half circle by adding 5
         let e:Int = IntParser.normalize(a, 12)//clamps the values between 0 and 12
//         guard let line = shapeLayer.sublayers?[e] else { fatalError("line doesnt exist")}
//         Swift.print("alpha:  \(alpha)")
//         line.borderColor = line.borderColor?.copy(alpha: alpha)
         guard let line:CAShapeLayer = self.shapeLayer.sublayers?[e] as? CAShapeLayer else { fatalError("line doesnt exist")}
//         Swift.print("line:  \(line)")
         line.strokeColor = line.strokeColor?.copy(alpha: alpha)
      }
   }
   /**
    * Basically Tick the lines into visibility one by one (from the top one)
    * NOTE: Reveal one tick at the time from top
    * NOTE: You also want to set the alpha gradually from half to full alpha in a half circle
    * TODO: The final tick should be 0, to make this happen you need to offset the i, possibly
    */
   func reveal(_ value:CGFloat){/*value goes from 0 to 1*/
      //Swift.print("ProgressIndicator.reveal() value: " + "\(value)")
      revealProgress = value
      let initAlpha = lineStyle.strokeColor.cgColor.alpha//<--can be moved to a global scope
      let restAlpha = 1 - initAlpha//<--can be moved to a global scope
      let p:Int = Int(round(12 * value)) //progression from 0 to 12
      for i in 0..<12{
         var alpha:CGFloat
         if i < p {//integers before p
            if i >= p-6 && i <= p {//<--TODO: ⚠️️ use range here
               let relLoc:CGFloat = 7 - CGFloat(p - i)//Figure out where the i is in the range: p-6 until p
               //Swift.print("relLoc: " + "\(relLoc)")
               let multiplier:CGFloat = relLoc/6//base the relative pos as the multiplier for the alpha level.
               //Swift.print("multiplier: " + "\(multiplier)")
               alpha = initAlpha + (restAlpha * multiplier)//max equals 1 alpha, min equals 0.5
            }else{
               alpha = initAlpha
            }
         }else{//integers after p
            alpha = 0
         }
//         guard let line = shapeLayer.sublayers?[i] else { fatalError("line doesnt exist")}
//         line.borderColor = line.borderColor?.copy(alpha: alpha)
         guard let line:CAShapeLayer = self.shapeLayer.sublayers?[i] as? CAShapeLayer else { fatalError("line doesnt exist")}
//         Swift.print("line:  \(line)")
         line.strokeColor = line.strokeColor?.copy(alpha: alpha)
      }
   }
}
/**
 * Iteration
 */
fileprivate class IntParser{
   /**
    * Return a  Random number within a min max value
    * EXAMPLE: IntParser.random(0,3)//Can return either of: 0,1,2,3
    */
   static func random(_ min:Int, _ max:Int)->Int{//returns an integer between 0 - x
      return Int(arc4random_uniform(UInt32(max)) + UInt32(min))
   }
   /**
    * Returns a normalized integer value (loopy index)
    * NOTE: Great for iterating int arrays
    * NOTE: Can be used for looping items in an array (carousel etc)
    * EXAMPLE:
    * print(IntParser.normalize(3, 7))//3
    * print(IntParser.normalize(-3, 7))//4
    * print(IntParser.normalize(0, 7))//0
    * print(IntParser.normalize(7, 7))//0
    * print(IntParser.normalize(8, 7))//1
    * print(IntParser.normalize(12, 7))//5
    * Was: return index >= 0 ? (index < len ? index : index % len) : (len + (index % len))//IMPORTANT: print(IntParser.normalize(-7, 7)) yields 7, which is wrong it should be 0
    */
   static func normalize(_ index:Int,_ len:Int) -> Int {
      if index >= 0 {
         if index < len{
            return index
         }else {
            return index % len
         }
      }else {
         if index % len == 0 {
            return 0
         }else {
            return len + (index % len)
         }
      }
   }
}

import UIKit

/**
 * Math
 */
internal extension CGPoint{
   /**
    * Returns a point, in a polar cordinate system (from 0,0), for PARAM: angle and PARAM: length
    * Return: a point on a circle where the pivot is TopLeft Corner (0,0)
    * PARAM: radius: the radius of the circle
    * PARAM: angle: the angle where the point is (in radians) (-π to π) (3.14.. to 3.14..)
    * NOTE: formula "<angle*cos*radius,angle*sin*radius>"
    * NOTE: One can also use Point.polar(radius,radian) or equivilent method in the spesific language
    * Base formula CosΘ = x/len
    * Base Formula SinΘ = y/len
    * EXAMPLE: CGPoint.polarPoint(100, π/4)//polarPoint:  (70.7106781186548, 70.7106781186547) bottomRight corner
    * NOTE: π = Double.pi
    */
   func polarPoint(_ radius:CGFloat, _ angle:CGFloat) -> CGPoint {/*Convenience*/
      let x:CGFloat = /*radius + */(radius * cos(angle))
      let y:CGFloat = /*radius + */(radius * sin(angle))
      return CGPoint(x:self.x + x, y:self.y + y)
   }
}
/**
 * TypeAlias / default values
 */
extension ProgressIndicator {
   static let defaultStyle:LineStyle = (.clear,UIColor.black.withAlphaComponent(0.2),3)
   typealias LineStyle = (backgroundColor:UIColor,strokeColor:UIColor,strokeWidth:CGFloat)
}

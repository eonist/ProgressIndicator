import UIKit

/**
 * TypeAlias / default values
 */
extension ProgressIndicator {
   static let defaultStyle: LineStyle = (.clear, UIColor.black.withAlphaComponent(0.2), 3)
   public typealias LineStyle = (backgroundColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat)
}
/**
 * Math
 */
extension CGPoint {
   /**
    * Returns a point, in a polar cordinate system (from 0,0), for PARAM: angle and PARAM: length
    * Return: a point on a circle where the pivot is TopLeft Corner (0,0)
    * - PARAM: radius: the radius of the circle
    * - PARAM: angle: the angle where the point is (in radians) (-π to π) (3.14.. to 3.14..)
    * - NOTE: formula "<angle*cos*radius,angle*sin*radius>"
    * - NOTE: One can also use Point.polar(radius,radian) or equivilent method in the spesific language
    * Base formula CosΘ = x/len
    * Base Formula SinΘ = y/len
    * ## EXAMPLEs:
    * CGPoint.polarPoint(100, π/4)//polarPoint:  (70.7106781186548, 70.7106781186547) bottomRight corner
    * NOTE: π = Double.pi
    */
   internal func polarPoint(_ radius: CGFloat, _ angle: CGFloat) -> CGPoint {/*Convenience*/
      let x: CGFloat = /*radius + */(radius * cos(angle))
      let y: CGFloat = /*radius + */(radius * sin(angle))
      return CGPoint(x: self.x + x, y: self.y + y)
   }
}
/**
 * Iteration
 */
internal class IntParser {
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
   static func normalize(_ index: Int, _ len: Int) -> Int {
      if index >= 0 {
         if index < len {
            return index
         } else {
            return index % len
         }
      } else {
         if index % len == 0 {
            return 0
         }else {
            return len + (index % len)
         }
      }
   }
}
/**
 * CGShape extension
 */
internal class CGShapeUtil {
   /**
    * Draw line
    * NOTE: remember to: shapeLayer.addSublayer(lineLayer)
    * It's also possible to do this with UIBezierPath
    * let path:UIBezierPath = {
    *    let aPath = UIBezierPath.init()
    *    aPath.move(to: p1)
    *    aPath.addLine(to: p2)
    *    aPath.close()//Keep using the method addLineToPoint until you get to the one where about to close the path
    *    return aPath
    * }()
    */
   static func drawLine(_ lineLayer: CAShapeLayer, line: (p1: CGPoint, p2: CGPoint), style: (stroke: UIColor, strokeWidth: CGFloat)) -> CAShapeLayer {
      let lineLayer: CAShapeLayer = .init()
      let path: CGMutablePath = .init()
      path.move(to: line.p1)
      path.addLine(to: line.p2)
      lineLayer.path = path/*Setup the CAShapeLayer with the path, colors, and line width*/
      lineLayer.strokeColor = style.stroke.cgColor
      lineLayer.lineWidth = style.strokeWidth
      lineLayer.lineCap = .round
      return lineLayer
   }
}

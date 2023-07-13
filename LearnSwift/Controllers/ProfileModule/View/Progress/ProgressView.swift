import Foundation
import UIKit

final class ProgressView: UIView {
    func drawProgress(with persent: CGFloat) {
        
        let circleFrame: CGFloat = UIConstants.circleFrame
        let radius = circleFrame / 2
        let center = CGPoint(x: radius, y: radius)
        let startAngle = -CGFloat.pi
        let endAngle = CGFloat.pi
        
        let circlePath = UIBezierPath(arcCenter: center,
                                      radius: radius,
                                      startAngle: startAngle,
                                      endAngle: endAngle,
                                      clockwise: true)
        
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = UIConstants.progressViewColor.cgColor
        circleLayer.lineWidth = UIConstants.circleLayerLineWidth
        circleLayer.strokeEnd = persent
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        
        let defaultCircleLayer = CAShapeLayer()
        defaultCircleLayer.path = circlePath.cgPath
        defaultCircleLayer.strokeColor = UIColor.lightGray.cgColor
        defaultCircleLayer.lineWidth = UIConstants.defaultCircleLayerLineWidth
        defaultCircleLayer.strokeEnd = UIConstants.defaultCircleLayerStroke
        defaultCircleLayer.fillColor = UIConstants.backgroundColor.cgColor
        defaultCircleLayer.lineCap = .round
        
        let dotAngle = CGFloat.pi * ((1.0 - persent) - persent)
        let dotPoint = CGPoint(x: cos(-dotAngle) * radius + center.x,
                               y: sin(-dotAngle) * radius + center.y)
        let dotPath = UIBezierPath()
        dotPath.move(to: dotPoint)
        dotPath.addLine(to: dotPoint)
        
        let dotLayer = CAShapeLayer()
        dotLayer.path = dotPath.cgPath
        dotLayer.fillColor = UIColor.clear.cgColor
        dotLayer.strokeColor = UIColor.white.cgColor
        dotLayer.lineCap = .round
        dotLayer.lineWidth = UIConstants.dotLineWidth
        
        layer.addSublayer(defaultCircleLayer)
        layer.addSublayer(circleLayer)
        layer.addSublayer(dotLayer)
    }
}

private enum UIConstants {
    static let circleFrame: CGFloat = 95
    static let circleLayerLineWidth: CGFloat = 4
    static let defaultCircleLayerLineWidth: CGFloat = 2
    static let defaultCircleLayerStroke: CGFloat = 1
    static let dotLineWidth: CGFloat = 4
    static let progressViewColor: UIColor = #colorLiteral(red: 1, green: 0.632538259, blue: 0.08776579052, alpha: 1)
    static let backgroundColor: UIColor = #colorLiteral(red: 0.2903108597, green: 0.2903108895, blue: 0.2903108597, alpha: 1)
}

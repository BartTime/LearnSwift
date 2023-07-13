import UIKit
import SnapKit

final class ChartView: UIView {
    
    private let yAxisSeparator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIConstants.separatorColor
        return view
    }()
    
    private let xAxisSeparator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIConstants.separatorColor
        return view
    }()
    
    var counts = 0
    var data = [PerformanceModel(value: 0, title: "")]
    var points: [CGPoint] = []
    var chartPath = UIBezierPath()
    var dotLayer = CAShapeLayer()
    var chartLayer = CAShapeLayer()
    var dotPath = UIBezierPath()
    
    func configure(with data: [PerformanceModel], counts: Int) {
        if self.data.count != 1 {
            deletePoints()
            self.data = data
            self.counts = counts
        } else {
            self.data = data
            self.counts = counts
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addDashLines()
        drawChart(with: data)
    }
}

extension ChartView {
    func setupViews() {
        
        addSubview(yAxisSeparator)
        addSubview(xAxisSeparator)
        
        yAxisSeparator.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.width.equalTo(UIConstants.separatorHeight)
        }
        
        xAxisSeparator.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(UIConstants.separatorHeight)
        }
    }
}

private extension ChartView {
    
    func addDashLines(with counts: Int? = nil) {
        (0..<self.counts).map{CGFloat($0)}.forEach {
            addDashLine(at: bounds.height / CGFloat(self.counts) * $0)
        }
    }
    
    func addDashLine(at yPosition: CGFloat) {
        let startPoint = CGPoint(x: 0, y: yPosition)
        let endPoint = CGPoint(x: bounds.width, y: yPosition)
        
        let dashPath = CGMutablePath()
        dashPath.addLines(between: [startPoint, endPoint])
        
        let dashLayer = CAShapeLayer()
        dashLayer.path = dashPath
        dashLayer.strokeColor = UIColor.black.cgColor
        dashLayer.lineWidth = UIConstants.dashLayerWidht
        dashLayer.lineDashPattern = [5, 5]
        
        layer.addSublayer(dashLayer)
    }
    
    func drawChart(with data: [PerformanceModel]) {
        var maxValue = 0
        
        for i in data {
            if i.value > maxValue {
                maxValue = i.value
            }
        }
        
        let temp = Double(maxValue)/Double(10)
        let final = Int(ceil(temp))
        
        guard let maxValue = data.sorted(by: { $0.value > $1.value }).first?.value else { return }
        let valuePoints = data.enumerated().map({ CGPoint(x: CGFloat($0), y: CGFloat($1.value)) })
        let chartHeigh = bounds.height / CGFloat(final * 10)
        
        self.points = valuePoints.map({
            let x = bounds.width / CGFloat(valuePoints.count - 1) * $0.x
            let y = bounds.height - $0.y * chartHeigh
            return CGPoint(x: x, y: y)
        })
        
//        let chartPath = UIBezierPath()
        self.chartPath.move(to: self.points[0])
        drawChartDot(at: self.points[0])
        
        self.points.forEach{
            self.chartPath.addLine(to: $0)
            drawChartDot(at: $0)
        }
        
//        let chartLayer = CAShapeLayer()
        self.chartLayer.path = self.chartPath.cgPath
        self.chartLayer.strokeColor = UIConstants.lineColor.cgColor
        self.chartLayer.lineWidth = UIConstants.chartWidthLine
        self.chartLayer.strokeEnd = UIConstants.strokeEndWidth
        self.chartLayer.lineJoin = .round
        self.chartLayer.fillColor = UIConstants.clearColor.cgColor
        
        layer.addSublayer(self.chartLayer)
    }
    
    func drawChartDot(at point: CGPoint) {
//        let dotPath = UIBezierPath()
        self.dotPath.move(to: point)
        self.dotPath.addLine(to: point)
        
//        let dotLayer = CAShapeLayer()
//        self.dotLayer = CAShapeLayer()
        self.dotLayer.path = self.dotPath.cgPath
        self.dotLayer.strokeColor = UIConstants.lineColor.cgColor
        self.dotLayer.lineCap = .round
        self.dotLayer.lineWidth = UIConstants.dotWith
        
        layer.addSublayer(self.dotLayer)
    }
    
    func deletePoints() {
//        self.points.forEach { _ in
        self.chartPath.removeAllPoints()
        self.dotLayer.removeFromSuperlayer()
        self.dotLayer.strokeColor = UIColor.clear.cgColor
        self.dotPath.removeAllPoints()
        self.dotPath = UIBezierPath()
        self.dotLayer = CAShapeLayer()
        self.chartPath.removeAllPoints()
        self.chartLayer.removeFromSuperlayer()
        self.chartLayer.strokeColor = UIColor.clear.cgColor
//        self.points = []
//        view.subviews.forEach({ $0.removeFromSuperview() })
//        layer.sublayers?.forEach({ $0.removeFromSuperlayer() })
    }
}

private enum UIConstants {
    static let dotWith: CGFloat = 10
    static let chartWidthLine: CGFloat = 3
    static let strokeEndWidth: CGFloat = 1
    static let separatorHeight: CGFloat = 1
    static let dashLayerWidht: CGFloat = 1
    static let separatorColor: UIColor = .lightGray
    static let clearColor: UIColor = .clear
    static let lineColor: UIColor = #colorLiteral(red: 1, green: 0.632538259, blue: 0.08776579052, alpha: 1)
}

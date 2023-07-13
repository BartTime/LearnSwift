import Foundation
import SnapKit
import UIKit

final class WAChartsView: UIView {
    
    private let yAxisView = YAxisView()
    private let xAxisView = XAxisView()
    private let chartsView = ChartView()
      
    func configure(with data: [PerformanceModel]) {
        chartsView.setupViews()
        yAxisView.translatesAutoresizingMaskIntoConstraints = false
        xAxisView.translatesAutoresizingMaskIntoConstraints = false
        chartsView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(yAxisView)
        addSubview(xAxisView)
        addSubview(chartsView)
        setupView()
        
        yAxisView.configure(with: data)
        xAxisView.configure(with: data)
        
        chartsView.configure(with: data, counts: 10)
    }
}

extension WAChartsView {
    func setupView() {
        
        yAxisView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(xAxisView.snp.top).inset(UIConstants.yAxisBottom)
        }

        xAxisView.snp.makeConstraints { make in
            make.leading.equalTo(yAxisView.snp.trailing).inset(UIConstants.xAxisLeadin)
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview().inset(UIConstants.xAxisTrailing)
        }

        chartsView.snp.makeConstraints { make in
            make.leading.equalTo(yAxisView.snp.trailing).inset(UIConstants.chartsViewLeading)
            make.top.equalToSuperview().inset(UIConstants.chartsViewTop)
            make.trailing.equalToSuperview().inset(UIConstants.chartsViewTrailing)
            make.bottom.equalTo(xAxisView.snp.top).inset(UIConstants.chartsViewBottom)
        }
    }
}

private enum UIConstants {
    static let yAxisBottom: CGFloat = -12
    static let xAxisLeadin: CGFloat = -8
    static let xAxisTrailing: CGFloat = 4
    static let chartsViewLeading: CGFloat = -8
    static let chartsViewTop: CGFloat = 4
    static let chartsViewTrailing: CGFloat = 4
    static let chartsViewBottom: CGFloat = -16
}

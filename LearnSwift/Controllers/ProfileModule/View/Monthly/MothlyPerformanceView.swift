import Foundation
import SnapKit
import UIKit

final class MothlyPerformanceView: UIView {
    private let chartsView = WAChartsView()
    
    func configure(with items: [PerformanceModel]) {
        chartsView.translatesAutoresizingMaskIntoConstraints = false
        chartsView.configure(with: items)
    }
}

extension MothlyPerformanceView {
    func setupView() {
        addSubview(chartsView)
        
        chartsView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.chartsViewTop)
            make.leading.equalToSuperview().inset(UIConstants.chartsViewLeading)
            make.trailing.equalToSuperview().inset(UIConstants.chartsViewTrailing)
            make.bottom.equalToSuperview().inset(UIConstants.chartsViewBottom)
        }
    }
}

private enum UIConstants {
    static let chartsViewTop: CGFloat = 15
    static let chartsViewLeading: CGFloat = 10
    static let chartsViewTrailing: CGFloat = 10
    static let chartsViewBottom: CGFloat = 15
}

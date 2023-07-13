import Foundation
import SnapKit
import UIKit

final class YAxisView: UIView {
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .equalSpacing
        return view
    }()
    
    func configure(with data: [PerformanceModel]) {
        stackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        var maxValue = 0
        for i in data {
            if i.value > maxValue {
                maxValue = i.value
            }
        }
        
        if maxValue < 10 {
            (0...10).reversed().forEach {
                let label = UILabel()
                label.font = UIConstants.labelFont
                label.textColor = UIConstants.labelTextColor
                label.textAlignment = .right
                label.text = "\($0)"
                
                stackView.addArrangedSubview(label)
            }
        } else {
            let temp = Double(maxValue)/Double(10)
            let final = Int(ceil(temp))
            (0...10).reversed().forEach {
                let label = UILabel()
                label.font = UIConstants.labelFont
                label.textColor = UIConstants.labelTextColor
                label.textAlignment = .right
                label.text = "\($0 * final)"
                
                stackView.addArrangedSubview(label)
            }
        }
        
        setupViews()
    }
}

extension YAxisView {
    func setupViews() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview()
        }
    }
}

private enum UIConstants {
    static let labelFont: UIFont = .systemFont(ofSize: 10)
    static let labelTextColor: UIColor = .white
}

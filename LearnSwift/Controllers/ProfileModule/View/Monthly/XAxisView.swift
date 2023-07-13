import SnapKit
import UIKit

final class XAxisView: UIView {
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .equalSpacing
        return view
    }()
    
    func configure(with data: [PerformanceModel]) {
        stackView.arrangedSubviews.forEach {
            $0.removeFromSuperview()
        }
        
        data.forEach {
            let label = UILabel()
            label.font = .systemFont(ofSize: 9)
            label.textColor = .white
            label.textAlignment = .center
            label.text = $0.title.uppercased()
            
            stackView.addArrangedSubview(label)
        }
        setupViews()
    }
}

extension XAxisView {
    func setupViews() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.top.trailing.leading.bottom.equalToSuperview()
        }
    }
}

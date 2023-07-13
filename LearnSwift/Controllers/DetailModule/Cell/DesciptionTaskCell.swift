import Foundation
import SnapKit
import UIKit

class DesciptionTaskCell: UITableViewCell {
    
    //MARK: - Public
    func configure(rowColor: UIColor, title: String, text: String) {
        self.contentView.backgroundColor = rowColor
        self.exampleTitleLabel.text = title
        self.exampleLabel.text = text
    }
    
    public static var identifier: String {
        get {
            return "DescriptionTaskCell"
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private properties
    private let exampleTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: UIConstants.exampleSizeText, weight: .bold)
        return label
    }()
    
    private let exampleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIConstants.textColor
        return label
    }()
    
}

private extension DesciptionTaskCell {
    func initialize() {
        contentView.addSubview(exampleTitleLabel)
        exampleTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.defaultInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.defaultInset)
        }
        
        contentView.addSubview(exampleLabel)
        exampleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIConstants.defaultInset)
            make.top.equalTo(exampleTitleLabel.snp.bottom).inset(-UIConstants.topAndBottomInset)
            make.bottom.equalToSuperview()
        }
    }
}

private enum UIConstants {
    static let backgroundColor: UIColor = #colorLiteral(red: 0.2282280028, green: 0.2282280028, blue: 0.2282280028, alpha: 1)
    static let defaultInset: CGFloat = 16
    static let topAndBottomInset: CGFloat = 10
    static let viewCornerRadius: CGFloat = 10
    static let textColor: UIColor = .white
    static let exampleSizeText: CGFloat = 25
}

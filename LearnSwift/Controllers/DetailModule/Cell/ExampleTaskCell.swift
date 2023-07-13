import Foundation
import SnapKit
import UIKit

class ExampleTaskCell: UITableViewCell {
    
    //MARK: - Public
    func configure(rowColor: UIColor, title: String, text: String) {
        self.contentView.backgroundColor = rowColor
        self.exampleTitleLabel.text = title
        self.exampleLabel.text = text
    }
    
    public static var identifier: String {
        get {
            return "ExampleTaskCell"
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
        label.textColor = UIConstants.textColor
        label.font = .systemFont(ofSize: UIConstants.exampleSizeText, weight: .bold)
        return label
    }()
    
    private let view: UIView = {
        let view = UIView()
        view.clipsToBounds = false
        view.layer.shadowOpacity = UIConstants.shadowOpacity
        view.layer.shadowColor = UIConstants.shadowColor
        view.backgroundColor = UIConstants.backgroundColor
        view.layer.cornerRadius = UIConstants.viewCornerRadius
        return view
    }()
    
    private let exampleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIConstants.textColor
        return label
    }()
    
}

private extension ExampleTaskCell {
    func initialize() {
        contentView.addSubview(exampleTitleLabel)
        exampleTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(UIConstants.defaultInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.defaultInset)
        }
        
        contentView.addSubview(view)
        view.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIConstants.defaultInset)
            make.bottom.equalToSuperview().inset(UIConstants.topAndBottomInset)
            make.top.equalTo(exampleTitleLabel.snp.bottom).inset(-UIConstants.labelToDescriptionInser)
        }
        
        view.addSubview(exampleLabel)
        exampleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIConstants.insetForDescriptionLabel)
        }
    }
}

private enum UIConstants {
    static let backgroundColor: UIColor = #colorLiteral(red: 0.2282280028, green: 0.2282280028, blue: 0.2282280028, alpha: 1)
    static let labelToDescriptionInser: CGFloat = 10
    static let defaultInset: CGFloat = 16
    static let topAndBottomInset: CGFloat = 5
    static let viewCornerRadius: CGFloat = 10
    static let insetForDescriptionLabel = 8
    static let textColor: UIColor = #colorLiteral(red: 0.9284570813, green: 0.9284570813, blue: 0.9284570813, alpha: 1)
    static let exampleSizeText: CGFloat = 25
    static let shadowOpacity: Float = 0.7
    static let shadowColor: CGColor = #colorLiteral(red: 0.7602825761, green: 0.3373456895, blue: 0.904338479, alpha: 1)
}

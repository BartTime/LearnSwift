import UIKit
import SnapKit

class InfoTableViewCell: UITableViewCell {

    //MARK: - Public
    func configure(rowColor: UIColor) {
        contentView.backgroundColor = rowColor
        self.completingTaskLabel.text = "Status"
        self.taskNameLabel.text = "Title"
        self.difficultyLabel.text = "Difficulty"
    }
    
    public static var identifier: String {
        get {
            return "InfoTableViewCell"
        }
    }
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private properties
    private let completingTaskLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.fontSize)
        label.textColor = UIConstants.textColor
        return label
    }()
    
    private let taskNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.fontSize)
        label.textColor = UIConstants.textColor
        return label
    }()
    
    private let difficultyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: UIConstants.fontSize)
        label.textColor = UIConstants.textColor
        return label
    }()
}

//MARK: - Private methods
private extension InfoTableViewCell {
    func initialize() {
        selectionStyle = .none
        contentView.addSubview(completingTaskLabel)
        completingTaskLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.centerY.equalToSuperview()
            make.size.equalTo(UIConstants.completingTaskImageSize)
        }
        
        contentView.addSubview(difficultyLabel)
        difficultyLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.centerY.equalTo(completingTaskLabel)
        }
        
        contentView.addSubview(taskNameLabel)
        taskNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(completingTaskLabel.snp.trailing).offset(UIConstants.taskNameToCompletingTaskImageOffset)
            make.trailing.equalTo(difficultyLabel.snp.leading)
        }
    }
}

private enum UIConstants {
    static let textColor: UIColor = #colorLiteral(red: 0.3204078078, green: 0.3246639073, blue: 0.3289075494, alpha: 1)
    static let fontSize: CGFloat = 13
    static let contentInset: CGFloat = 16
    static let contentTopInset: CGFloat = 8
    static let completingTaskImageSize = 40
    static let taskNameToCompletingTaskImageOffset: CGFloat = 10
    static let greenColor: UIColor = #colorLiteral(red: 0.3954334855, green: 0.6769045591, blue: 0.3914109468, alpha: 1)
    static let redColor: UIColor = #colorLiteral(red: 0.7817292809, green: 0.3032317162, blue: 0.2282724679, alpha: 1)
    static let yellowColor: UIColor = #colorLiteral(red: 1, green: 0.852222681, blue: 0.6064352393, alpha: 1)
}

import UIKit
import SnapKit

class TaskTableViewCell: UITableViewCell {
    
    //MARK: - Public
    func configure(with info: TaskTableCellViewModel, rowColor: UIColor) {
        self.contentView.backgroundColor = rowColor
        self.completingTaskImage.image = UIImage(systemName: "circlebadge")
        self.completingTaskImage.tintColor = .gray
        self.taskNameLabel.text = "\(info.id). " + info.name
        if info.completed == true {
            self.completingTaskImage.image = UIImage(systemName: "circlebadge")
            self.completingTaskImage.tintColor = .systemGreen
        }
        if info.difiiculty == 0 {
            self.difficultyLabel.text = "Easy"
            self.difficultyLabel.textColor = UIConstants.greenColor
        } else if info.difiiculty == 1 {
            self.difficultyLabel.text = "Medium"
            self.difficultyLabel.textColor = UIConstants.yellowColor
        } else {
            self.difficultyLabel.text = "Hard"
            self.difficultyLabel.textColor = UIConstants.redColor
        }
    }
    
    public static var identifier: String {
        get {
            return "TaskTableViewCell"
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
    private let completingTaskImage: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        return view
    }()
    
    private let taskNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.taskNameFontSize, weight: .medium)
        label.textColor = UIConstants.textColor
        label.numberOfLines = 1
        return label
    }()
    
    private let difficultyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: UIConstants.taskNameFontSize)
        label.textColor = UIConstants.textColor
        return label
    }()
}

//MARK: - Private methods
private extension TaskTableViewCell {
    func initialize() {
        selectionStyle = .none
        contentView.addSubview(completingTaskImage)
        completingTaskImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(UIConstants.contentInset)
            make.centerY.equalToSuperview()
            make.size.equalTo(UIConstants.completingTaskImageSize)
        }
        
        contentView.addSubview(difficultyLabel)
        difficultyLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.centerY.equalTo(completingTaskImage)
        }
        
        contentView.addSubview(taskNameLabel)
        taskNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(completingTaskImage.snp.trailing).offset(UIConstants.taskNameToCompletingTaskImageOffset)
            make.trailing.equalTo(difficultyLabel.snp.leading)
        }
    }
}

private enum UIConstants {
    static let textColor: UIColor = .white
    static let taskNameFontSize: CGFloat = 17
    static let contentInset: CGFloat = 16
    static let contentTopInset: CGFloat = 8
    static let completingTaskImageSize = 40
    static let taskNameToCompletingTaskImageOffset: CGFloat = 10
    static let greenColor: UIColor = #colorLiteral(red: 0.3954334855, green: 0.6769045591, blue: 0.3914109468, alpha: 1)
    static let redColor: UIColor = #colorLiteral(red: 0.7817292809, green: 0.3032317162, blue: 0.2282724679, alpha: 1)
    static let yellowColor: UIColor = #colorLiteral(red: 1, green: 0.852222681, blue: 0.6064352393, alpha: 1)
}

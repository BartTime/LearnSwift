import UIKit
import SnapKit

class DifficultyItemCell: UICollectionViewCell {
    
    var viewModel: MainViewModel!
    var difficult = ""
    
    func configure(with difficult: String, textColor: UIColor, viewModel: MainViewModel) {
        self.difficult = difficult
        self.difficultyButtonLabel.setTitle(difficult, for: .normal)
        self.difficultyButtonLabel.tintColor = textColor
        self.viewModel = viewModel
    }
    
    public static var identifier: String {
        get {
            return "DifficultyItemCell"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let difficultyButtonLabel: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.2145400047, green: 0.2145400047, blue: 0.2145400047, alpha: 1)
        button.tintColor = #colorLiteral(red: 0.7709746957, green: 0.7781118751, blue: 0.7923391461, alpha: 1)
        button.layer.cornerRadius = 10
        return button
    }()
}

private extension DifficultyItemCell {
    func initialize() {
        contentView.addSubview(difficultyButtonLabel)
        difficultyButtonLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        difficultyButtonLabel.addTarget(self, action: #selector(filterBy), for: .touchUpInside)
    }

    @objc func filterBy() {
        self.viewModel.filterByDifficulty(difficulty: difficult)
    }
}

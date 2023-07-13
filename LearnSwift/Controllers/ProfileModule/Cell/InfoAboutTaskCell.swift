import SnapKit
import UIKit


class InfoAboutTaskCell: UITableViewCell {
    
    //MARK: - Public
    func configure(data: SortedProfileDataModel) {
        contentView.backgroundColor = UIConstants.cellBackgroundColor
        
        sumOfCompletedTask.text = "\(data.allCompletedTasks)"
        
        easyCompletedLabel.text = "\(data.completedEasyDifficultTask)"
        mediumCompletedLabel.text = "\(data.completedMediumDifficultTask)"
        hardCompletedLabel.text = "\(data.completedHardDifficultTask)"
        
        easyCountLabel.text = "/\(data.easyDifficultTaskAll)"
        mediumCountLabel.text = "/\(data.mediumDifficultTaskAll)"
        hardCountLabel.text = "/\(data.hardDifficultTaskAll)"
        
        easyPersentsLabel.text = "\(data.persentsOfEasyTasks * 100)%"
        mediumPersentsLabel.text = "\(data.persentsOfMediumTasks * 100)%"
        hardPersentsLabel.text = "\(data.persentsOfHardTasks * 100)%"
        
        easyProgressView.setProgress(data.persentsOfEasyTasks, animated: true)
        mediumProgressView.setProgress(data.persentsOfMediumTasks, animated: true)
        hardProgressView.setProgress(data.persentsOfHardTasks, animated: true)
        
        let sumOfPersents = Float(data.allCompletedTasks)/Float(data.sumAllTasks)
        progressView.drawProgress(with: CGFloat(sumOfPersents))
    }
    
    public static var identifier: String {
        get {
            return "InfoAboutTaskCell"
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
    private let backgorundView: UIView = {
        let view = UIView()
        
        view.layer.cornerRadius = UIConstants.cornerRadius
        view.backgroundColor = UIConstants.backgroundViewColor
        
        view.layer.shadowOpacity = UIConstants.shadowOpacity
        view.layer.shadowColor = UIConstants.shadowColor
        
        return view
    }()
    
    private let titleCell: UILabel = {
        let label = UILabel()
        label.textColor = UIConstants.titleTextColor
        label.font = .systemFont(ofSize: UIConstants.titleTextSize)
        label.text = "Completed tasks"
        return label
    }()
    
    private let sumOfCompletedTask: UILabel = {
        let label = UILabel()
        label.text = "25"
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: UIConstants.sumOfCompletedTaskFont, weight: .bold)
        return label
    }()
    
    private let completedTask: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Completed"
        label.textColor = UIConstants.titleTextColor
        label.font = .systemFont(ofSize: UIConstants.completedTaskLableFont)
        return label
    }()
    
    private let progressView: ProgressView = {
        let view = ProgressView()
        return view
    }()
    
    private let easyLabel: UILabel = {
        let label = UILabel()
        label.text = "Easy"
        label.textColor = UIConstants.hardLabelFontColor
        label.font = .systemFont(ofSize: UIConstants.dificultLabelFont)
        return label
    }()
    
    private let easyCompletedLabel: UILabel = {
        let label = UILabel()
        label.text = "19"
        label.textColor = .white
        label.font = .systemFont(ofSize: UIConstants.dificultCompletedLabelFont, weight: .bold)
        return label
    }()
    
    private let easyCountLabel: UILabel = {
        let label = UILabel()
        label.text = "/654"
        label.textColor = UIConstants.countAllTaskColor
        label.font = .systemFont(ofSize: UIConstants.dificultCountLabelFont)
        return label
    }()
    
    private let easyBeatsLabel: UILabel = {
        let label = UILabel()
        label.text = "Beats"
        label.textColor = UIConstants.hardLabelFontColor
        label.font = .systemFont(ofSize: UIConstants.dificultLabelFont)
        return label
    }()
    
    private let easyPersentsLabel: UILabel = {
        let label = UILabel()
        label.text = "50.1%"
        label.textColor = UIConstants.persentsColor
        label.font = .systemFont(ofSize: UIConstants.dificultPersentsLabelFont, weight: .medium)
        return label
    }()
    
    private let easyProgressView: UIProgressView = {
        let view = UIProgressView()
        view.progressTintColor = UIConstants.easyProgressViewColor
        view.trackTintColor = UIConstants.easyProgressTintViewColor
        view.setProgress(19.0/654.0, animated: true)
        return view
    }()
    
    
    
    private let mediumLabel: UILabel = {
        let label = UILabel()
        label.text = "Medium"
        label.textColor = UIConstants.hardLabelFontColor
        label.font = .systemFont(ofSize: UIConstants.dificultLabelFont)
        return label
    }()
    
    private let mediumCompletedLabel: UILabel = {
        let label = UILabel()
        label.text = "6"
        label.textColor = .white
        label.font = .systemFont(ofSize: UIConstants.dificultCompletedLabelFont, weight: .bold)
        return label
    }()
    
    private let mediumCountLabel: UILabel = {
        let label = UILabel()
        label.text = "/1410"
        label.textColor = UIConstants.countAllTaskColor
        label.font = .systemFont(ofSize: UIConstants.dificultCountLabelFont)
        return label
    }()
    
    private let mediumBeatsLabel: UILabel = {
        let label = UILabel()
        label.text = "Beats"
        label.textColor = UIConstants.hardLabelFontColor
        label.font = .systemFont(ofSize: UIConstants.dificultLabelFont)
        return label
    }()
    
    private let mediumPersentsLabel: UILabel = {
        let label = UILabel()
        label.text = "28.6%"
        label.textColor = UIConstants.persentsColor
        label.font = .systemFont(ofSize: UIConstants.dificultPersentsLabelFont, weight: .medium)
        return label
    }()
    
    private let mediumProgressView: UIProgressView = {
        let view = UIProgressView()
        view.progressTintColor = UIConstants.mediumProgressViewColor
        view.trackTintColor = UIConstants.mediumProgressTintViewColor
        view.setProgress(6.0/1410.0, animated: true)
        return view
    }()
    
    
    
    private let hardLabel: UILabel = {
        let label = UILabel()
        label.text = "Hard"
        label.textColor = UIConstants.hardLabelFontColor
        label.font = .systemFont(ofSize: UIConstants.dificultLabelFont)
        return label
    }()
    
    private let hardCompletedLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.textColor = .white
        label.font = .systemFont(ofSize: UIConstants.dificultCompletedLabelFont, weight: .bold)
        return label
    }()
    
    private let hardCountLabel: UILabel = {
        let label = UILabel()
        label.text = "/590"
        label.textColor = UIConstants.countAllTaskColor
        label.font = .systemFont(ofSize: UIConstants.dificultCountLabelFont)
        return label
    }()
    
    private let hardBeatsLabel: UILabel = {
        let label = UILabel()
        label.text = "Beats"
        label.textColor = UIConstants.hardLabelFontColor
        label.font = .systemFont(ofSize: UIConstants.dificultLabelFont)
        return label
    }()
    
    private let hardPersentsLabel: UILabel = {
        let label = UILabel()
        label.text = "0.0%"
        label.textColor = UIConstants.persentsColor
        label.font = .systemFont(ofSize: UIConstants.dificultPersentsLabelFont, weight: .medium)
        return label
    }()
    
    private let hardProgressView: UIProgressView = {
        let view = UIProgressView()
        view.progressTintColor = UIConstants.hardProgressViewColor
        view.trackTintColor = UIConstants.hardProgressTintViewColor
        view.setProgress(10.0/590.0, animated: true)
        return view
    }()
}

//MARK: - Private methods
private extension InfoAboutTaskCell {
    func initialize() {
        contentView.addSubview(backgorundView)
        backgorundView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(UIConstants.defaultInset)
            make.height.equalTo(UIConstants.backgroundViewHeight)
        }
        
        backgorundView.addSubview(titleCell)
        titleCell.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview().inset(UIConstants.defaultInset)
        }
        
        backgorundView.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.top.equalTo(titleCell.snp.bottom).inset(UIConstants.progressViewTop)
            make.width.equalTo(UIConstants.completedStackViewWidthd)
            make.leading.equalToSuperview().inset(UIConstants.progressViewLeading)
            make.centerY.equalToSuperview()
        }
        
        let sumOfCompletedTasks = UIStackView()
        sumOfCompletedTasks.axis = .vertical
        sumOfCompletedTasks.spacing = UIConstants.sumOfCompletedTasksSpacing
        sumOfCompletedTasks.addArrangedSubview(sumOfCompletedTask)
        sumOfCompletedTasks.addArrangedSubview(completedTask)
        
        backgorundView.addSubview(sumOfCompletedTasks)
        sumOfCompletedTasks.snp.makeConstraints { make in
            make.width.equalTo(UIConstants.completedStackViewWidthd)
            make.leading.equalToSuperview().inset(UIConstants.defaultInset)
            make.centerY.equalToSuperview()
        }
        
        let easyStatsStackView = UIStackView()
        easyStatsStackView.axis = .horizontal
        easyStatsStackView.spacing = UIConstants.statsStackViewSpacing
        easyStatsStackView.addArrangedSubview(easyLabel)
        easyStatsStackView.addArrangedSubview(easyCompletedLabel)
        easyStatsStackView.addArrangedSubview(easyCountLabel)
        easyStatsStackView.addArrangedSubview(easyBeatsLabel)
        easyStatsStackView.addArrangedSubview(easyPersentsLabel)
        
        backgorundView.addSubview(easyStatsStackView)
        easyStatsStackView.snp.makeConstraints { make in
            make.leading.equalTo(sumOfCompletedTasks.snp.trailing).inset(-UIConstants.defaultInset)
            make.top.equalTo(titleCell.snp.bottom).inset(-UIConstants.dificultyInset)
            make.trailing.equalToSuperview().inset(UIConstants.defaultInset)
        }
        
        backgorundView.addSubview(easyProgressView)
        easyProgressView.snp.makeConstraints { make in
            make.leading.equalTo(sumOfCompletedTasks.snp.trailing).inset(-UIConstants.defaultInset)
            make.top.equalTo(easyStatsStackView.snp.bottom).inset(-UIConstants.stackViewToProgressViewInset)
            make.trailing.equalToSuperview().inset(UIConstants.defaultInset)
            make.height.equalTo(UIConstants.heightProgressView)
        }
        
        let mediumStatsStackView = UIStackView()
        mediumStatsStackView.axis = .horizontal
        mediumStatsStackView.spacing = UIConstants.statsStackViewSpacing
        mediumStatsStackView.addArrangedSubview(mediumLabel)
        mediumStatsStackView.addArrangedSubview(mediumCompletedLabel)
        mediumStatsStackView.addArrangedSubview(mediumCountLabel)
        mediumStatsStackView.addArrangedSubview(mediumBeatsLabel)
        mediumStatsStackView.addArrangedSubview(mediumPersentsLabel)
        
        backgorundView.addSubview(mediumStatsStackView)
        mediumStatsStackView.snp.makeConstraints { make in
            make.leading.equalTo(sumOfCompletedTasks.snp.trailing).inset(-UIConstants.defaultInset)
            make.top.equalTo(easyProgressView.snp.bottom).inset(-UIConstants.dificultyInset)
            make.trailing.equalToSuperview().inset(UIConstants.defaultInset)
        }
        
        backgorundView.addSubview(mediumProgressView)
        mediumProgressView.snp.makeConstraints { make in
            make.leading.equalTo(sumOfCompletedTasks.snp.trailing).inset(-UIConstants.defaultInset)
            make.top.equalTo(mediumStatsStackView.snp.bottom).inset(-UIConstants.stackViewToProgressViewInset)
            make.trailing.equalToSuperview().inset(UIConstants.defaultInset)
            make.height.equalTo(UIConstants.heightProgressView)
        }
        
        
        let hardStatsStackView = UIStackView()
        hardStatsStackView.axis = .horizontal
        hardStatsStackView.spacing = UIConstants.statsStackViewSpacing
        hardStatsStackView.addArrangedSubview(hardLabel)
        hardStatsStackView.addArrangedSubview(hardCompletedLabel)
        hardStatsStackView.addArrangedSubview(hardCountLabel)
        hardStatsStackView.addArrangedSubview(hardBeatsLabel)
        hardStatsStackView.addArrangedSubview(hardPersentsLabel)
        
        backgorundView.addSubview(hardStatsStackView)
        hardStatsStackView.snp.makeConstraints { make in
            make.leading.equalTo(sumOfCompletedTasks.snp.trailing).inset(-UIConstants.defaultInset)
            make.top.equalTo(mediumProgressView.snp.bottom).inset(-UIConstants.dificultyInset)
            make.trailing.equalToSuperview().inset(UIConstants.defaultInset)
        }
        
        backgorundView.addSubview(hardProgressView)
        hardProgressView.snp.makeConstraints { make in
            make.leading.equalTo(sumOfCompletedTasks.snp.trailing).inset(-UIConstants.defaultInset)
            make.top.equalTo(hardStatsStackView.snp.bottom).inset(-UIConstants.stackViewToProgressViewInset)
            make.trailing.equalToSuperview().inset(UIConstants.defaultInset)
            make.height.equalTo(UIConstants.heightProgressView)
        }
    }
}

private enum UIConstants {
    static let cornerRadius: CGFloat = 15
    static let cellBackgroundColor: UIColor = #colorLiteral(red: 0.1019608006, green: 0.1019608006, blue: 0.1019608006, alpha: 1)
    static let backgroundViewHeight: CGFloat = 200
    static let backgroundViewColor: UIColor = #colorLiteral(red: 0.2274509966, green: 0.2274509966, blue: 0.2274509966, alpha: 1)
    static let defaultInset: CGFloat = 16
    static let titleTextColor: UIColor = #colorLiteral(red: 0.6288433671, green: 0.6288433671, blue: 0.6288433671, alpha: 1)
    static let titleTextSize: CGFloat = 15
    static let completedTaskLableFont: CGFloat = 16
    static let sumOfCompletedTaskFont: CGFloat = 23
    static let sumOfCompletedTasksSpacing: CGFloat = 10
    static let completedStackViewWidthd: CGFloat = 80
    static let hardLabelFontColor: UIColor = #colorLiteral(red: 0.6325663924, green: 0.6288433671, blue: 0.6399977207, alpha: 1)
    static let countAllTaskColor: UIColor = #colorLiteral(red: 0.4117870033, green: 0.4117870033, blue: 0.4117870033, alpha: 1)
    static let persentsColor: UIColor = #colorLiteral(red: 0.7314814329, green: 0.7386966348, blue: 0.7458940148, alpha: 1)
    static let pestentsFont: CGFloat = 19
    
    static let dificultyInset: CGFloat = 13
    static let dificultLabelFont: CGFloat = 13
    static let dificultCompletedLabelFont: CGFloat = 16
    static let dificultCountLabelFont: CGFloat = 15
    static let dificultPersentsLabelFont: CGFloat = 16
    static let stackViewToProgressViewInset: CGFloat = 10
    static let heightProgressView: CGFloat = 8
    
    static let progressViewLeading: CGFloat = 8
    static let progressViewTop: CGFloat = -30
    
    static let statsStackViewSpacing: CGFloat = 10
    
    static let easyProgressTintViewColor: UIColor = #colorLiteral(red: 0.1531933844, green: 0.3032830656, blue: 0.2053302228, alpha: 1)
    static let easyProgressViewColor: UIColor = #colorLiteral(red: 0.02110948227, green: 0.7206495404, blue: 0.6325607896, alpha: 1)
    
    static let mediumProgressTintViewColor: UIColor = #colorLiteral(red: 0.3499886394, green: 0.2859591544, blue: 0.1385451555, alpha: 1)
    static let mediumProgressViewColor: UIColor = #colorLiteral(red: 0.7852608562, green: 0.6436973214, blue: 0.3873260617, alpha: 1)
    
    static let hardProgressTintViewColor: UIColor = #colorLiteral(red: 0.349996984, green: 0.1866674423, blue: 0.1819745302, alpha: 1)
    static let hardProgressViewColor: UIColor = #colorLiteral(red: 1, green: 0.214409411, blue: 0.3708360195, alpha: 1)
    
    static let shadowOpacity: Float = 0.7
    static let shadowColor: CGColor = #colorLiteral(red: 0.7602825761, green: 0.3373456895, blue: 0.904338479, alpha: 1)
}

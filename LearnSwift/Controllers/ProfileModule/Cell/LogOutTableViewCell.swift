import UIKit
import SnapKit

class LogOutTableViewCell: UITableViewCell {
    
    //MARK: - Public
    var viewModel: ProfileViewModel?
    func configure(data: SortedProfileDataModel, viewModel: ProfileViewModel){
        contentView.backgroundColor = UIConstants.viewBackgroundColor
        self.viewModel = viewModel
    }
    
    public static var identifier: String {
        get {
            return "LogOutTableViewCell"
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
    private let logOutButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = UIConstants.cornerRadiusButton
        button.backgroundColor = UIConstants.redColor
        button.setTitle("Log Out", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
}

//MARK: - Private methods
private extension LogOutTableViewCell {
    func initialize() {
        contentView.addSubview(logOutButton)
        logOutButton.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview().inset(UIConstants.defaultInset)
            make.height.equalTo(UIConstants.buttonHeight)
        }
        
        logOutButton.addTarget(self, action: #selector(logOut), for: .touchUpInside)
    }
    
    @objc func logOut() {
        self.viewModel?.logOut()
    }
}

private enum UIConstants {
    static let viewBackgroundColor: UIColor = #colorLiteral(red: 0.1019608006, green: 0.1019608006, blue: 0.1019608006, alpha: 1)
    static let cornerRadiusButton: CGFloat = 10
    static let buttonHeight: CGFloat = 40
    static let redColor: UIColor = #colorLiteral(red: 0.7817292809, green: 0.3032317162, blue: 0.2282724679, alpha: 1)
    static let defaultInset: CGFloat = 16
    static let shadowOpacity: Float = 0.7
}

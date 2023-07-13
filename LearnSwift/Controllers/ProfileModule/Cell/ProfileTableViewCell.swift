import SnapKit
import UIKit

class ProfileTableViewCell: UITableViewCell {
    
    //MARK: - Public
    func configure(data: SortedProfileDataModel, viewModel: ProfileViewModel) {
        nameLabel.text = data.name
        contentView.backgroundColor = UIConstants.cellBackgroundColor
        self.viewModel = viewModel
    }
    
    public static var identifier: String {
        get {
            return "ProfileTableViewCell"
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
    
    private var viewModel: ProfileViewModel!
    
    private let backgorundView: UIView = {
        let view = UIView()
        view.clipsToBounds = false
        
        view.layer.shadowOpacity = UIConstants.shadowOpacity
        view.layer.shadowColor = UIConstants.shadowColor
        
        view.backgroundColor = UIConstants.backgroundColorView
        view.layer.cornerRadius = UIConstants.viewCornerRadius
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .systemFont(ofSize: UIConstants.fontSize)
        label.textColor = .white
        return label
    }()
    
    private let userImage: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.backgroundColor = .gray
        view.tintColor = .white
        view.layer.cornerRadius = UIConstants.viewCornerRadius
        view.image = UIImage(systemName: "person.fill")
        return view
    }()
    
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = UIConstants.cornerRadiusButton
        button.backgroundColor = UIConstants.greenColor
        button.setTitle("Edit profile", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
}

//MARK: - Private methods
private extension ProfileTableViewCell {
    func initialize() {
        contentView.addSubview(backgorundView)
        backgorundView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIConstants.deafaultInset)
            make.top.bottom.equalToSuperview().inset(UIConstants.topBottomDefaultInset)
            make.height.equalTo(UIConstants.backgroundViewHeight)
        }
        
        backgorundView.addSubview(editProfileButton)
        editProfileButton.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(UIConstants.deafaultInset)
            make.bottom.equalToSuperview().inset(UIConstants.deafaultInset)
            make.height.equalTo(UIConstants.buttonHeight)
        }
        
        backgorundView.addSubview(userImage)
        userImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(UIConstants.deafaultInset)
            make.bottom.equalTo(editProfileButton.snp.top).inset(-UIConstants.deafaultInset)
            make.width.equalTo(UIConstants.widthImageSize)
        }
        backgorundView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(UIConstants.deafaultInset)
            make.leading.equalTo(userImage.snp.trailing).inset(-UIConstants.deafaultInset)
        }
        
        editProfileButton.addTarget(self, action: #selector(goToEditVC), for: .touchUpInside)
    }
    
    @objc func goToEditVC() {
        viewModel.goToEditProfileFunc()
    }
}

private enum UIConstants {
    static let greenColor: UIColor = #colorLiteral(red: 0.3954334855, green: 0.6769045591, blue: 0.3914109468, alpha: 1)
    static let deafaultInset: CGFloat = 16
    static let topBottomDefaultInset: CGFloat = 16
    static let buttonHeight: CGFloat = 30
    static let cornerRadiusButton: CGFloat = 5
    static let backgroundColorView: UIColor = #colorLiteral(red: 0.2282280028, green: 0.2282280028, blue: 0.2282280028, alpha: 1)
    static let viewCornerRadius: CGFloat = 15
    static let backgroundViewHeight: CGFloat = 150
    static let cellBackgroundColor: UIColor = #colorLiteral(red: 0.1019608006, green: 0.1019608006, blue: 0.1019608006, alpha: 1)
    static let widthImageSize: CGFloat = 72
    static let fontSize: CGFloat = 17
    
    static let shadowOpacity: Float = 0.7
    static let shadowColor: CGColor = #colorLiteral(red: 0.7602825761, green: 0.3373456895, blue: 0.904338479, alpha: 1)
}

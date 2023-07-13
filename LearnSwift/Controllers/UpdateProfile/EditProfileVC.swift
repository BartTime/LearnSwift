import UIKit

class EditProfileVC: UIViewController {
    
    var viewModel: EditProfileViewModel = EditProfileViewModel()

    //MARK: - Variables
    var router: RouterProtocol
    
    required init(router: RouterProtocol) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        bindViewModel()
    }
    
    func configureView() {
        self.view.backgroundColor = #colorLiteral(red: 0.1019608006, green: 0.1019608006, blue: 0.1019608006, alpha: 1)
        self.titleLabel.text = "Edit Profile"
        self.actionButton.setTitle("Edit", for: .normal)
        self.initializeView()
        
        let defaults = UserDefaults.standard
        
        let password = defaults.string(forKey: "Password")
        let name = defaults.string(forKey: "UserName")
        
        guard let password = password, let name = name else { return }
        passwordTextField.text = password
        nameTextField.text = name
        
    }
    
    //MARK: - Private properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.titleLabelFont, weight: .bold)
        label.textAlignment = .center
        label.textColor = UIConstants.titleLabelColor
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Enter your name"
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your password"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.5456466675, green: 0.9215924144, blue: 0.4836524725, alpha: 1)
        button.tintColor = .white
        button.layer.cornerRadius = 15
        return button
    }()
}

//MARK: - Private methods
private extension EditProfileVC {
    func initializeView() {
        let textFieldStack = UIStackView()
        textFieldStack.axis = .vertical
        textFieldStack.addArrangedSubview(nameTextField)
        textFieldStack.addArrangedSubview(passwordTextField)
        textFieldStack.spacing = UIConstants.textFieldSpacing
        view.addSubview(textFieldStack)
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        textFieldStack.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(UIConstants.standartInset)
        }
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(textFieldStack.snp.top).offset(-UIConstants.titleLabelToTextFieldStackInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.standartInset)
        }
        view.addSubview(actionButton)
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(textFieldStack.snp.bottom).offset(UIConstants.titleLabelToTextFieldStackInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.standartInset)
            make.height.equalTo(UIConstants.actionButtonHeight)
        }
        
        actionButton.addTarget(self, action: #selector(returnToVC), for: .touchUpInside)
    }
    
    @objc func returnToVC() {
        let password = passwordTextField.text ?? ""
        viewModel.checkParams(pasword: password)
    
    }
    
    func dismissController() {
        self.router.dismissVC()
    }
}

//MARK: - BindViewModel
private extension EditProfileVC {
    func bindViewModel() {
        viewModel.errorPassword.subscribe { [weak self] rez in
            guard let self = self else { return }
            switch rez {
            case .next(let isError):
                if isError {
                    DispatchQueue.main.async {
                        let password = self.passwordTextField.text ?? ""
                        let name = self.nameTextField.text ?? ""
                        self.viewModel.putData(name: name, password: password)
                    }
                } else {
                    DispatchQueue.main.async {
                        let allert = ShowAllertController().showAllertController(title: "Ошибка", message: "Пароль должен составлять минимум из 8 символов")
                        self.present(allert, animated: true)
                    }
                }
            case .error(_):
                break
            case .completed:
                break
            }
        }
        
        viewModel.dataSource.subscribe { [weak self] rezult in
            guard let self = self else { return }
            switch rezult {
            case .next(let data):
                DispatchQueue.main.async {
                    let defaults = UserDefaults.standard
                    
                    let passFromTextField = self.passwordTextField.text ?? ""
                    let nameFromTextField = self.nameTextField.text ?? ""
                    
                    defaults.set(passFromTextField, forKey: "Password")
                    defaults.set(nameFromTextField, forKey: "UserName")
                    
                    self.dismissController()
                }
            case .error(_):
                break
            case .completed:
                break
            }
        }
        
        viewModel.error.subscribe { [weak self] rez in
            guard let self = self else { return }
            switch rez {
            case .next(_):
                DispatchQueue.main.async {
                    let allert = ShowAllertController().showAllertController(title: "Ошибка", message: "Ошибка входа")
                    self.present(allert, animated: true)
                }
            case .error(_):
                break
            case .completed:
                break
            }
        }
    }
}

private enum UIConstants {
    static let titleLabelColor: UIColor = .white
    static let titleLabelFont: CGFloat = 40
    static let labelColor: UIColor = #colorLiteral(red: 0.3204078078, green: 0.3246639073, blue: 0.3289075494, alpha: 1)
    static let labelFont: CGFloat = 20
    static let textFieldSpacing: CGFloat = 18
    static let titleLabelToTextFieldStackInset: CGFloat = 35
    static let standartInset: CGFloat = 16
    static let actionButtonHeight: CGFloat = 45
    static let textFieldHeight: CGFloat = 40
}


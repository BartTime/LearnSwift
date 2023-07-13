import UIKit

class RegisterViewController: UIViewController {
    
    var viewModel: RegisterViewModel = RegisterViewModel()
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
        
        hideNavBar()
        configureView()
        bindViewModel()
    }
    
    func configureView() {
        self.view.backgroundColor = #colorLiteral(red: 0.1019608006, green: 0.1019608006, blue: 0.1019608006, alpha: 1)
        self.titleLabel.text = "Sign Up"
        self.actionButton.setTitle("Sign Up", for: .normal)
        self.signInLabel.text = "Do you have An Account?"
        self.initializeView()
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
        textField.placeholder = "Enter your name"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private let gmailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Enter your gmail"
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your password"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let secondPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your password again"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 10
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = #colorLiteral(red: 0.5456466675, green: 0.9215924144, blue: 0.4836524725, alpha: 1)
        button.tintColor = .white
        button.layer.cornerRadius = 15
        return button
    }()
    
    private let signInLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.labelFont)
        label.textColor = UIConstants.labelColor
        label.textAlignment = .center
        return label
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
}

//MARK: - Private methods
private extension RegisterViewController {
    func initializeView() {
        let textFieldStack = UIStackView()
        textFieldStack.axis = .vertical
        textFieldStack.addArrangedSubview(nameTextField)
        textFieldStack.addArrangedSubview(gmailTextField)
        textFieldStack.addArrangedSubview(passwordTextField)
        textFieldStack.addArrangedSubview(secondPasswordTextField)
        textFieldStack.spacing = UIConstants.textFieldSpacing
        view.addSubview(textFieldStack)
        nameTextField.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        gmailTextField.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        secondPasswordTextField.snp.makeConstraints { make in
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
        view.addSubview(signInLabel)
        signInLabel.snp.makeConstraints { make in
            make.top.equalTo(actionButton.snp.bottom).offset(UIConstants.titleLabelToTextFieldStackInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.standartInset)
        }
        
        actionButton.addTarget(self, action: #selector(openMainViewController), for: .touchUpInside)
        
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIConstants.standartInset)
            make.top.equalTo(signInLabel.snp.bottom).inset(-UIConstants.textFieldSpacing)
        }
        signInButton.addTarget(self, action: #selector(goToLoginViewController), for: .touchUpInside)
    }
    
    @objc func goToLoginViewController() {
        router.initialViewController()
    }
    
    @objc func openMainViewController() {
        checkParams()
    }
    
    func checkParams() {
        let name = nameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        let secondPassword = secondPasswordTextField.text ?? ""
        let email = gmailTextField.text ?? ""
        
        viewModel.checkParams(name: name, email: email, password: password, secondPassword: secondPassword)
        bindViewModelRegister(name: name, email: email, password: password, secondPassword: secondPassword)
    }
    
    func pushToMainVC() {
        router.showTabBar()
    }
}

//MARK: - BindViewModel
private extension RegisterViewController {
    func bindViewModel() {
        viewModel.dataSource.subscribe { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .next(let data):
                DispatchQueue.main.async {
                    self.saveUser(data: data)
                    self.pushToMainVC()
                }
            case .error(let error):
                print(error)
            case .completed:
                break
            }
        }
    }
    
    func bindViewModelRegister(name: String, email: String, password: String, secondPassword: String) {
        viewModel.checked.subscribe { [weak self] event in
            guard let self = self else { return }
            switch event.element {
            case .ok:
                self.viewModel.postData(name: name, email: email, password: password)
            case .email:
                DispatchQueue.main.async {
                    let allert = ShowAllertController().showAllertController(title: "Ошибка", message: "Введите корректный email")
                    self.present(allert, animated: true)
                }
            case .name:
                DispatchQueue.main.async {
                    let allert = ShowAllertController().showAllertController(title: "Ошибка", message: "Введите имя")
                    self.present(allert, animated: true)
                }
            case .passwordCount:
                DispatchQueue.main.async {
                    let allert = ShowAllertController().showAllertController(title: "Ошибка", message: "Пароль должен составлять минимум из 8 символов")
                    self.present(allert, animated: true)
                }
            case .secondPassword:
                DispatchQueue.main.async {
                    let allert = ShowAllertController().showAllertController(title: "Ошибка", message: "введеные пароли не совпадают")
                    self.present(allert, animated: true)
                }
            case .none:
                break
            }
        }
    }
    
    func saveUser(data: LoginRegistrationAccessModel) {
        let defaults = UserDefaults.standard
        
        let password = passwordTextField.text
        let email = gmailTextField.text
        let id = viewModel.dataModel?.id
        
        defaults.set(password, forKey: "Password")
        defaults.set(email, forKey: "Email")
        defaults.set(id, forKey: "UserId")
        defaults.set(data.access_token, forKey: "JWTToken")
    }
}

extension RegisterViewController {
    func hideNavBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    func showNavBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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


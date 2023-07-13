import UIKit

class LoginViewController: UIViewController {
    
    var viewModel: LoginViewModel = LoginViewModel()
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
        let defaults = UserDefaults.standard
        
        let password = defaults.string(forKey: "Password")
        let email = defaults.string(forKey: "Email")
        
        hideNavBar()
        configureView()
        bindViewModel()
        
        guard let password = password, let email = email else { return }
        if password != "" && email != "" {
            openMainVC(password: password, email: email)
        }
    }
    
    func configureView() {
        self.view.backgroundColor = #colorLiteral(red: 0.1019608006, green: 0.1019608006, blue: 0.1019608006, alpha: 1)
        self.titleLabel.text = "Sign In"
        self.actionButton.setTitle("Sign In", for: .normal)
        self.signUpLabel.text = "Dont have An Account?"
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
        textField.isSecureTextEntry = true
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
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIConstants.labelFont)
        label.textColor = UIConstants.labelColor
        label.textAlignment = .center
        return label
    }()
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        return button
    }()
}

//MARK: - Private methods
private extension LoginViewController {
    func initializeView() {
        let textFieldStack = UIStackView()
        textFieldStack.axis = .vertical
        textFieldStack.addArrangedSubview(gmailTextField)
        textFieldStack.addArrangedSubview(passwordTextField)
        textFieldStack.spacing = UIConstants.textFieldSpacing
        view.addSubview(textFieldStack)
        gmailTextField.snp.makeConstraints { make in
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
        view.addSubview(signUpLabel)
        signUpLabel.snp.makeConstraints { make in
            make.top.equalTo(actionButton.snp.bottom).offset(UIConstants.titleLabelToTextFieldStackInset)
            make.leading.trailing.equalToSuperview().inset(UIConstants.standartInset)
        }
        
        actionButton.addTarget(self, action: #selector(openMainViewController), for: .touchUpInside)
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIConstants.standartInset)
            make.top.equalTo(signUpLabel.snp.bottom).inset(-UIConstants.textFieldSpacing)
        }
        
        signUpButton.addTarget(self, action: #selector(goToRegisterViewController), for: .touchUpInside)
    }
    
    @objc func goToRegisterViewController() {
        router.showRegisterVC()
    }
    
    @objc func openMainViewController() {
        let password = passwordTextField.text ?? ""
        let email = gmailTextField.text ?? ""
        viewModel.postData(email: email, password: password)
    }
    
    func openMainVC(password: String, email: String) {
        viewModel.postData(email: email, password: password)
    }
    
    func pushToMainVC() {
        router.showTabBar()
    }
}

//MARK: - BindViewModel
private extension LoginViewController {
    func bindViewModel() {
        
        viewModel.error.subscribe { [weak self] event in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let allert = ShowAllertController().showAllertController(title: "Ошибка", message: "Ошибка входа")
                self.present(allert, animated: true)
            }
        }
        
        viewModel.data.subscribe { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .next(let data):
                let defaults = UserDefaults.standard
                let password = defaults.string(forKey: "Password")
                let email = defaults.string(forKey: "Email")
                DispatchQueue.main.async {
                    let passFromTextField = self.passwordTextField.text ?? ""
                    let emailFromTextField = self.gmailTextField.text ?? ""
                    
                    if password == nil || password == "" || email == nil || email == "" {
                        defaults.set(passFromTextField, forKey: "Password")
                        defaults.set(emailFromTextField, forKey: "Email")
                        defaults.set(data.id, forKey: "UserId")
                    }
                    
                    defaults.set(data.access_token, forKey: "JWTToken")
                    self.pushToMainVC()
                }
            case .error(let error):
                print(error)
            case .completed:
                break
            }
        }
    }
}

extension LoginViewController {
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

func getNavVC(rootVC: UIViewController) -> UINavigationController {
    let navVC = UINavigationController(rootViewController: rootVC)
    navVC.navigationBar.prefersLargeTitles = true
    navVC.navigationBar.barStyle = .black
    navVC.navigationBar.isTranslucent = false
    navVC.navigationBar.backgroundColor = .black
    
    return navVC
}


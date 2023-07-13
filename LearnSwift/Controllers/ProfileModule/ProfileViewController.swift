import UIKit
import SnapKit

class ProfileViewController: UIViewController {
    
    //MARK: - ViewModel
    var viewModel: ProfileViewModel = ProfileViewModel()
    var dataSource: SortedProfileDataModel = SortedProfileDataModel()
    
    //MARK: - Variables
    let myTableView = UITableView()
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
        self.myTableView.rowHeight = UITableView.automaticDimension
        self.myTableView.estimatedRowHeight = 44.0
        
        configureView()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.myTableView.reloadData()
        self.dataSource = SortedProfileDataModel()
        viewModel.getTaskForUser()
    }
}

private extension ProfileViewController {
    func configureView() {
        title = "Profile"
        myTableView.dataSource = self
        myTableView.delegate = self
        view.addSubview(myTableView)
        myTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.backgroundColor = UIConstants.backgroundColor
        viewModel.getTaskForUser()
        setupTableView()
    }
    
    func bindViewModel() {
        
        viewModel.dataSource.subscribe { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .next(let rezult):
                DispatchQueue.main.async {
                    self.dataSource = rezult
                    self.reloadTableView()
                }
            case .error(let error):
                print(error)
            case .completed:
                break
            }
        }
        
        viewModel.error.subscribe { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let allet = ShowAllertController().showAllertController(title: "Ошибка", message: "Упс что-то пошло не так попробуйте зайти позже")
                self.present(allet, animated: true)
            }
        }
        
        viewModel.goToEditProfile.subscribe { [weak self] rez in
            guard let self = self else { return }
            switch rez {
            case .next(_):
                DispatchQueue.main.async {
                    self.router.showEditProfile()
                }
            case .error(let error):
                print(error)
            case .completed:
                break
            }
        }
        
        viewModel.goLogOut.subscribe { [weak self] rez in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.router.popToRoot()
            }
        }
    }
}

private enum UIConstants {
    static let backgroundColor: UIColor = #colorLiteral(red: 0.1019608006, green: 0.1019608006, blue: 0.1019608006, alpha: 1)
}

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    //MARK: - ViewModel
    var viewModel: MainViewModel = MainViewModel()
    
    //MARK: - Variables
    var cellDataSource: [TaskTableCellViewModel] = []
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

        configureNavBar()
        configureView()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getData()
    }
    
}

private extension MainViewController {
    func configureView() {
        self.navigationItem.title = "Tasks"
        view.backgroundColor = .black
        myTableView.dataSource = self
        myTableView.delegate = self
        view.addSubview(myTableView)
        myTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setupTableView()
    }
    
    func bindViewModel() {
        viewModel.cellDS.subscribe { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .next(let data):
                self.cellDataSource = data
                self.reloadTableView()
            case .error(let error):
                print(error)
            case .completed:
                break
            }
        }
        
        viewModel.cellFilteredDS.subscribe { [weak self] event in
            guard let self = self else { return }
            switch event {
            case .next(let data):
                self.cellDataSource = data
                self.reloadTableView()
            case .error(let error):
                print(error)
            case .completed:
                break
            }
        }
        
        viewModel.error.subscribe { [weak self] event in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let allet = ShowAllertController().showAllertController(title: "Ошибка", message: "Упс что-то пошло не так попробуйте зайти позже")
                self.present(allet, animated: true)
            }
        }
    }
    
    func configureNavBar() {
        self.navigationItem.hidesBackButton = true
    }
}

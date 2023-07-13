import UIKit

class DetailViewController: UIViewController {
    
    //MARK: - ViewModel
    var viewModel: DetailViewModel = DetailViewModel()
    var cellDataSource: DetailCellViewModel = DetailCellViewModel(task: SomeTask(condition: "", id: 0, name: "", requiredFunc: "", ask: nil, examples: [Example(description: "")], tests: [Test(answer: "", taskTest: "")]))
    
    //MARK: - Variables
    var myTableView = UITableView()
    var id: Int!
    private lazy var spinner: CustomSpinnerSimple = {
        let spinner = CustomSpinnerSimple(squareLength: 70)
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.rowHeight = UITableView.automaticDimension
        self.myTableView.estimatedRowHeight = 44.0
        
        configueView()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getData(id: id)
    }

}

private extension DetailViewController {
    func configueView() {
        self.title = ""
        view.backgroundColor = .black
        myTableView.dataSource = self
        myTableView.delegate = self
        spinner.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(myTableView)
        myTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        setupTableView()
        view.addSubview(spinner)
    }
    
    func bindViewModel() {
        viewModel.cellDS.subscribe { [weak self] data in
            guard let self = self else { return }
            switch data {
            case .next(let data):
                self.cellDataSource = data
                self.reloadTableView()
            case .error(let error):
                print(error)
            case .completed:
                break
            }
        }
        
        viewModel.error.subscribe { [weak self] error in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                let allet = ShowAllertController().showAllertController(title: "Ошибка", message: "Упс что-то пошло не так попробуйте позже")
                self.present(allet, animated: true)
            }
        }
        
        viewModel.checkReqFunc.subscribe { [weak self] value in
            guard let self = self else { return }
            switch value {
            case .next(let val):
                if val {
                    self.spinner.startAnimation(delay: 0.01, replicates: 120)
                    self.viewModel.askForTask()
                } else {
                    DispatchQueue.main.async {
                        let allet = ShowAllertController().showAllertController(title: "Ошибка", message: "Вы изменили исходную функцию")
                        self.present(allet, animated: true)
                    }
                }
            case .error(let error):
                print(error)
            case .completed:
                break
            }
        }
        
        viewModel.checkCountsOfReturn.subscribe { [weak self] value in
            guard let self = self else { return }
            DispatchQueue.main.async {
                let allet = ShowAllertController().showAllertController(title: "Ошибка", message: "В функции отсутствует return")
                self.present(allet, animated: true)
            }
        }
        
        viewModel.errorWhenCheking.subscribe { [weak self] value in
            guard let self = self else { return }
            switch value{
            case .next(let val):
                DispatchQueue.main.async {
                    self.spinner.stopAnimation()
                }
                if val == false {
                    DispatchQueue.main.async {
                        let allet = ShowAllertController().showAllertController(title: "Успех", message: "Код проверен")
                        self.present(allet, animated: true)
                    }
                } else {
                    DispatchQueue.main.async {
                        let allet = ShowAllertController().showAllertController(title: "Ошибка", message: "При выполнении теста программа выдала неверный ответ. Проверьте крайние случаи.")
                        self.present(allet, animated: true)
                    }
                }
            case .error(_):
                break
            case .completed:
                break
            }
        }
        
        viewModel.errorWithCode.subscribe { [weak self] value in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.spinner.stopAnimation()
            }
            switch value {
            case .next(let val):
                DispatchQueue.main.async {
                    let allet = ShowAllertController().showAllertController(title: "Ошибка", message: val)
                    self.present(allet, animated: true)
                }
            case .error(let error):
                break
            case .completed:
                break
            }
        }
    }
}


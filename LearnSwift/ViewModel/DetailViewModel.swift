import Foundation
import RxSwift

class DetailViewModel {
    var dataSource: DetailModel?
    
    var cellDS: PublishSubject<DetailCellViewModel> = PublishSubject()
    var cellDSValue: DetailCellViewModel?
    var checkReqFunc: PublishSubject<Bool> = PublishSubject()
    var checkCountsOfReturn: PublishSubject<Bool> = PublishSubject()
    var error: PublishSubject<Bool> = PublishSubject()
    
    var errorWithCode: PublishSubject<String> = PublishSubject()
    var errorWhenCheking: PublishSubject<Bool> = PublishSubject()
    
    var taskTests = [String]()
    var taskId: Int = 0
    var textTask: String = ""
    
    func numberjsOfSection() -> Int {
        1
    }
    
    func numberOfRows(in section: Int) -> Int {
        (self.dataSource?.task[0].examples.count ?? 0) + 2
    }
    
    func getData(id: Int) {
        let id = String(id)
        APICaller.getSomeTask(id: id) { [weak self] result in
            switch result {
            case .success(let data):
                self?.dataSource = data
                self?.mapCellData()
            case .failure(_):
                self?.error.onNext(true)
            }
        }
    }
    
    func mapCellData() {
        self.cellDSValue = DetailCellViewModel(task: (self.dataSource?.task[0])!)
        self.cellDS.onNext(self.cellDSValue!)
    }
    
    func askForTask() {
        APICaller.postAskForTask(ask: textTask, task: taskId) { [weak self] result in
            switch result {
            case .success(let value):
                if let error = value.error {
                    self?.errorWithCode.onNext(error)
                } else {
                    if value.access {
                        self?.errorWhenCheking.onNext(false)
                    } else {
                        self?.errorWhenCheking.onNext(true)
                    }
                }
            case .failure(_):
                break
            }
        }
    }
    
    func checkRequredFunc(text: String, requredFunc: String, taskId: Int, taskTests: [String]) {
        self.textTask = text
        self.taskId = taskId
        self.taskTests = taskTests
        
        let separatedReqFunc = requredFunc.components(separatedBy: "\n")
        let checkRequredFuncInText = text.components(separatedBy: "\n")
        var sortTextFunc = Set<String>()
        var countOfReturns = 0
        
        var comment = false
        for i in checkRequredFuncInText {
            if i.contains("/**") {
                comment = true
            } else if i.contains("*/") {
                comment = false
            } else if i.contains("//") {
                continue
            } else {
                if !comment {
                    if i.contains("func") {
                        sortTextFunc.insert(i)
                    }
                    if i.contains("return") {
                        countOfReturns += 1
                    }
                }
            }
        }
        
        if countOfReturns < sortTextFunc.count {
            self.checkCountsOfReturn.onNext(false)
            return
        }
        
        comment = false
        for i in separatedReqFunc {
            if i.contains("/**") {
                comment = true
            } else if i.contains("*/") {
                comment = false
            } else if i.contains("//") {
                continue
            } else {
                if !comment {
                    if i.contains("func") {
                        if !sortTextFunc.contains(i) {
                            self.checkReqFunc.onNext(false)
                        }
                    }
                }
            }
        }
        self.checkReqFunc.onNext(true)
    }
}

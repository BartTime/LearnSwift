import Foundation
import RxSwift

class MainViewModel {
    var dataSource: TaskModel?
    
    var cellDS: PublishSubject<[TaskTableCellViewModel]> = PublishSubject()
    var cellDSValue: [TaskTableCellViewModel] = []
    var cellFilteredDS: PublishSubject<[TaskTableCellViewModel]> = PublishSubject()
    var error: PublishSubject<Bool> = PublishSubject()
    var cellFilteredDataSourc: [TaskTableCellViewModel] = []
    var selectedDifficult = false
    
    func numbersOfSection() -> Int {
        1
    }
    
    func numberOfRows(in section: Int) -> Int {
        if selectedDifficult {
            return self.cellFilteredDataSourc.count
        } else {
            return self.dataSource?.tasks.count ?? 0
        }
    }
    
    func getData() {
        APICaller.getTaskForMainVC { [weak self] result in
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
        var dataS = [TaskTableCellViewModel]()
        for data in dataSource?.tasks ?? [] {
            let taskTableCellViewModel = TaskTableCellViewModel()
            dataS.append(taskTableCellViewModel.convert(data: data, userTasks: dataSource?.user ?? UsersTasks(id: 0, name: "", tasks: [CompletedTaskForUser(id: -1, askForTasks: "", data: "")])))
        }
        let defaults = UserDefaults.standard
        defaults.set(dataSource?.user.name, forKey: "UserName")
        self.cellDSValue = dataS
        self.cellDS.onNext(cellDSValue)
        
    }
    
    func filterByDifficulty(difficulty: String) {
        self.selectedDifficult = true
        if difficulty == "Easy" {
            self.cellFilteredDataSourc = self.cellDSValue.filter({$0.difiiculty == 0})
            self.cellFilteredDS.onNext(self.cellFilteredDataSourc)
        } else if difficulty == "Medium" {
            self.cellFilteredDataSourc = self.cellDSValue.filter({$0.difiiculty==1})
            self.cellFilteredDS.onNext(self.cellFilteredDataSourc)
        } else if difficulty == "Hard" {
            self.cellFilteredDataSourc = self.cellDSValue.filter({$0.difiiculty == 2})
            self.cellFilteredDS.onNext(self.cellFilteredDataSourc)
        } else if difficulty == "All" {
            self.cellFilteredDataSourc = self.cellDSValue
            self.cellFilteredDS.onNext(self.cellFilteredDataSourc)
            self.selectedDifficult = false
        }
    }
}

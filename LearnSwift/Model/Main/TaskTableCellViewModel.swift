import Foundation

class TaskTableCellViewModel {
    var id: Int
    var name: String
    var difiiculty: Int
    var completed: Bool
    var data: Int
    
    init() {
        self.id = 0
        self.name = ""
        self.difiiculty = 0
        self.completed = false
        self.data = -1
    }
    
    func convert(data: Task, userTasks: UsersTasks) -> TaskTableCellViewModel {
        self.id = data.id
        self.name = data.name
        self.difiiculty = data.difficulty
        for i in userTasks.tasks {
            if i.id == data.id {
                self.completed = true
            }
        }
        return self
    }
    
    
}

import Foundation

class DetailCellViewModel {
    let condition: String
    let id: Int
    let name: String
    let ask: String?
    let requiredFunc: String
    let examples: [Example]
    let tests: [Test]
    
    init(task: SomeTask) {
        self.condition = task.condition
        self.id = task.id
        self.name = task.name
        self.requiredFunc = task.requiredFunc
        self.examples = task.examples
        self.tests = task.tests
        if task.ask != nil {
            self.ask = task.ask
        } else {
            self.ask = nil
        }
    }
}

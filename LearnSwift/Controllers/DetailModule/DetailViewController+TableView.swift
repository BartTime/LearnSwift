import Foundation
import UIKit

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        myTableView.backgroundColor = #colorLiteral(red: 0.1031767651, green: 0.1031767651, blue: 0.1031767651, alpha: 1)
        self.registerCell()
    }
    
    func registerCell() {
        myTableView.register(DesciptionTaskCell.self, forCellReuseIdentifier: DesciptionTaskCell.identifier)
        myTableView.register(ExampleTaskCell.self, forCellReuseIdentifier: ExampleTaskCell.identifier)
        myTableView.register(CodeTaskCell.self, forCellReuseIdentifier: CodeTaskCell.identifier)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            let title = "\(self.cellDataSource.id) \(self.cellDataSource.name)"
            self.title = title
            self.myTableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.viewModel.numberjsOfSection()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = myTableView.dequeueReusableCell(withIdentifier: DesciptionTaskCell.identifier, for: indexPath) as? DesciptionTaskCell else {
                return UITableViewCell()
            }
            let backgroundColor: UIColor = #colorLiteral(red: 0.1031767651, green: 0.1031767651, blue: 0.1031767651, alpha: 1)
            cell.configure(rowColor: backgroundColor, title: "Description", text: cellDataSource.condition)
            return cell
        } else if indexPath.row - 1 != cellDataSource.examples.count {
            guard let cell = myTableView.dequeueReusableCell(withIdentifier: ExampleTaskCell.identifier, for: indexPath) as? ExampleTaskCell else {
                return UITableViewCell()
            }
            let backgroundColor: UIColor = #colorLiteral(red: 0.1031767651, green: 0.1031767651, blue: 0.1031767651, alpha: 1)
            let title = "Example"
            let text = cellDataSource.examples[indexPath.row - 1].description
            cell.configure(rowColor: backgroundColor, title: title, text: text)
            return cell
        } else {
            guard let cell = myTableView.dequeueReusableCell(withIdentifier: CodeTaskCell.identifier, for: indexPath) as? CodeTaskCell else {
                return UITableViewCell()
            }
            let backgroundColor: UIColor = #colorLiteral(red: 0.1031767651, green: 0.1031767651, blue: 0.1031767651, alpha: 1)
            let text = cellDataSource.requiredFunc
            let taskId = cellDataSource.id
            var taskTests = [String]()
            let askFor = cellDataSource.ask
            for i in cellDataSource.tests {
                taskTests.append(i.taskTest)
            }
            cell.configure(rowColor: backgroundColor, text: text, viewModel: self.viewModel, taskId: taskId, taskTest: taskTests, ask: askFor)
            return cell
        }
    }
}

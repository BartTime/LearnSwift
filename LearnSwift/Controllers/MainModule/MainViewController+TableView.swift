import Foundation
import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        myTableView.backgroundColor = #colorLiteral(red: 0.1031767651, green: 0.1031767651, blue: 0.1031767651, alpha: 1)
        self.registerCell()
    }
    
    func registerCell() {
        myTableView.register(ChangeDifficultyTableViewCell.self, forCellReuseIdentifier: ChangeDifficultyTableViewCell.identifier)
        myTableView.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
        myTableView.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.myTableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numbersOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section) + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = myTableView.dequeueReusableCell(withIdentifier: ChangeDifficultyTableViewCell.identifier, for: indexPath) as? ChangeDifficultyTableViewCell else {
                return UITableViewCell()
            }
            let rowColor: UIColor = #colorLiteral(red: 0.1031767651, green: 0.1031767651, blue: 0.1031767651, alpha: 1)
            cell.configure(rowColor: rowColor, viewModel: self.viewModel)
            cell.selectionStyle = .none
            return cell
        } else if indexPath.row == 1 {
            guard let cell = myTableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier, for: indexPath) as? InfoTableViewCell else {
                return UITableViewCell()
            }
            let rowColor: UIColor = #colorLiteral(red: 0.1031767651, green: 0.1031767651, blue: 0.1031767651, alpha: 1)
            cell.configure(rowColor: rowColor)
            cell.selectionStyle = .none
            return cell
        }
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier, for: indexPath) as? TaskTableViewCell else {
            return UITableViewCell()
        }
        let cellViewModel = cellDataSource[(indexPath.row) - 2]
        var rowColor: UIColor = #colorLiteral(red: 0.1819669902, green: 0.1819669902, blue: 0.1819669902, alpha: 1)
        if indexPath.row % 2 == 1 {
            rowColor = #colorLiteral(red: 0.1031767651, green: 0.1031767651, blue: 0.1031767651, alpha: 1)
        }
        cell.configure(with: cellViewModel, rowColor: rowColor)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 1 {
            let id = self.cellDataSource[(indexPath.row)-2].id
            router.showDetailVC(id: id)
        }
    }
}

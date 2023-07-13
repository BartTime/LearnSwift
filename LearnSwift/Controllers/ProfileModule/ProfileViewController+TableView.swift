import Foundation
import UIKit

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func setupTableView() {
        myTableView.backgroundColor = UIConstants.backgroundColor
        self.registerCell()
    }
    
    func registerCell() {
        myTableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        myTableView.register(LogOutTableViewCell.self, forCellReuseIdentifier: LogOutTableViewCell.identifier)
        myTableView.register(InfoAboutTaskCell.self, forCellReuseIdentifier: InfoAboutTaskCell.identifier)
        myTableView.register(MothlyPerformanceViewCell.self, forCellReuseIdentifier: MothlyPerformanceViewCell.identifier)
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
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 3 {
            guard let cell = myTableView.dequeueReusableCell(withIdentifier: LogOutTableViewCell.identifier, for: indexPath) as? LogOutTableViewCell else { return UITableViewCell() }
            cell.configure(data: dataSource, viewModel: self.viewModel)
            return cell
        } else if indexPath.row == 2 {
            guard let cell = myTableView.dequeueReusableCell(withIdentifier: MothlyPerformanceViewCell.identifier, for: indexPath) as? MothlyPerformanceViewCell else { return UITableViewCell() }
            cell.configure(data: self.dataSource.completedTasksDate)
            return cell
        }else if indexPath.row == 1 {
            guard let cell = myTableView.dequeueReusableCell(withIdentifier: InfoAboutTaskCell.identifier, for: indexPath) as? InfoAboutTaskCell else { return UITableViewCell() }
            cell.configure(data: dataSource)
            return cell
        }
        guard let cell = myTableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as? ProfileTableViewCell else { return UITableViewCell() }
        cell.configure(data: dataSource, viewModel: self.viewModel)
        return cell
    }
}

private enum UIConstants {
    static let backgroundColor: UIColor = #colorLiteral(red: 0.1019608006, green: 0.1019608006, blue: 0.1019608006, alpha: 1)
}

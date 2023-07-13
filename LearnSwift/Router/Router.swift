import Foundation
import UIKit

protocol RoouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AsselderBuilderProtocol? { get set }
}

protocol RouterProtocol {
    func initialViewController()
    func showTabBar()
    func showRegisterVC()
    func showDetailVC(id: Int)
    func showEditProfile()
    func popToRoot()
    func dismissVC()
}

class Router: RouterProtocol {
    var navigationContorller: UINavigationController?
    var assemblyBuilder: AsselderBuilderProtocol?
    var tabBarController = CreateTabBar()
    
    init(navigationContorller: UINavigationController, assemblyBuilder: AsselderBuilderProtocol) {
        self.navigationContorller  = navigationContorller
        self.assemblyBuilder       = assemblyBuilder
    }
    
    func initialViewController() {
        if let navigationContorller = navigationContorller {
            guard let mainVC = assemblyBuilder?.createInitialVC(router: self) else { return }
            navigationContorller.pushViewController(mainVC, animated: true)
        }
    }
    
    func showRegisterVC() {
        if let navigationContorller = navigationContorller {
            guard let mainVC = assemblyBuilder?.createRegisterModule(router: self) else { return }
            navigationContorller.pushViewController(mainVC, animated: true)
        }
    }
    
    func showTabBar() {
        if let navigationContorller = navigationContorller {
            guard let tabBar = assemblyBuilder?.createMainModule(router: self, tabBar: tabBarController) else { return }
            navigationContorller.pushViewController(tabBar, animated: true)
        }
    }
    
    func showDetailVC(id: Int) {
        guard let vc = assemblyBuilder?.createDetailModule(router: self, id: id) else { return }
        tabBarController.pushVC(vc: vc, first: true)
    }
    
    func showEditProfile() {
        guard let vc = assemblyBuilder?.createEditProfileModule(router: self) else { return }
        tabBarController.pushVC(vc: vc, first: false)
    }
    
    func popToRoot() {
        if let navigationContorller = navigationContorller {
            navigationContorller.popToRootViewController(animated: true)
        }
    }
    
    func dismissVC() {
        tabBarController.dismissFromEditToProfile()
    }
}

import Foundation
import UIKit

class CreateTabBar {
    var firtNavVC = UINavigationController()
    var secondNavVC = UINavigationController()
    
    func createTabBarController(router: RouterProtocol) -> UITabBarController {
        let viewController = MainViewController(router: router)
        let profileVC = ProfileViewController(router: router)
        
        firtNavVC = getNavVC(rootVC: viewController)
        secondNavVC = getNavVC(rootVC: profileVC)
        
        let tabOneBarItem = UITabBarItem(title: "Tasks", image: UIImage(systemName: "list.bullet"), tag: 0)
        let tabTwoBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        
        firtNavVC.tabBarItem = tabOneBarItem
        secondNavVC.tabBarItem = tabTwoBarItem
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = UIConstants.tabBarColor
        tabBarController.tabBar.barTintColor = UIConstants.barTintColor
        tabBarController.setViewControllers([firtNavVC, secondNavVC], animated: true)
        
        return tabBarController
    }
    
    func pushVC(vc: UIViewController, first: Bool) {
        if first {
            self.firtNavVC.pushViewController(vc, animated: true)
        } else {
            self.secondNavVC.pushViewController(vc, animated: true)
        }
    }
    
    func dismissFromEditToProfile() {
        self.secondNavVC.popToRootViewController(animated: true)
    }
}

private enum UIConstants {
    static let barTintColor: UIColor = .white
    static let tabBarColor: UIColor = #colorLiteral(red: 0.1803921461, green: 0.1803921461, blue: 0.1803921461, alpha: 1)
}

import Foundation
import UIKit

protocol AsselderBuilderProtocol {
    func createInitialVC(router: RouterProtocol) -> UIViewController
    func createMainModule(router: RouterProtocol, tabBar: CreateTabBar) -> UITabBarController
    func createRegisterModule(router: RouterProtocol) -> UIViewController
    func createDetailModule(router: RouterProtocol, id: Int) -> UIViewController
    func createEditProfileModule(router: RouterProtocol) -> UIViewController
}

class AsselderModuleBuilder: AsselderBuilderProtocol {
    func createInitialVC(router: RouterProtocol) -> UIViewController {
        let view = LoginViewController(router: router)
        return view
    }
    
    func createRegisterModule(router: RouterProtocol) -> UIViewController {
        let view = RegisterViewController(router: router)
        return view
    }
    
    func createMainModule(router: RouterProtocol, tabBar: CreateTabBar) -> UITabBarController {
        let tabBarController = tabBar.createTabBarController(router: router)
        
        return tabBarController
    }
    
    func createDetailModule(router: RouterProtocol, id: Int) -> UIViewController {
        let vc = DetailViewController()
        vc.id = id
        return vc
    }
    
    func createEditProfileModule(router: RouterProtocol) -> UIViewController {
        let vc = EditProfileVC(router: router)
        return vc
    }
}

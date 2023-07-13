import Foundation
import UIKit

class ShowAllertController {
    func showAllertController(title: String, message: String) -> UIAlertController {
        let allert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        allert.addAction(UIAlertAction(title: "Ok", style: .default))
        return allert
    }
}

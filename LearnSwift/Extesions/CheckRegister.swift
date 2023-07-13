import Foundation

class CheckRegister {
    func checkEmail(email: String) -> Bool {
        if email.contains("@") {
            return true
        }
        return false
    }
    
    func checkPassword(password: String) -> Bool {
        if password.count < 8 {
            return false
        }
        return true
    }
}

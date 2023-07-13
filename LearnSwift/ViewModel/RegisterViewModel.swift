import Foundation
import RxSwift

class RegisterViewModel {
    enum ErrorWithCheck {
        case ok
        case name
        case email
        case passwordCount
        case secondPassword
    }
    
    var dataModel: LoginModel?
    var isChecked: Observable<ErrorWithCheck> = Observable(nil)
    
    var dataSource: PublishSubject<LoginRegistrationAccessModel> = PublishSubject()
    var checked: PublishSubject<ErrorWithCheck> = PublishSubject()
    
    func postData(name: String, email: String, password: String) {
        APICaller.register(name: name, email: email, password: password) { result in
            switch result {
            case .success(let data):
                self.dataModel = data
                self.dataSource.onNext(LoginRegistrationAccessModel(data: data))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func checkParams(name: String, email: String, password: String, secondPassword: String) {
        let checkParams = CheckRegister()
        if name == "" || name == " " {
            self.checked.onNext(ErrorWithCheck.name)
        } else if checkParams.checkEmail(email: email) == false {
            self.checked.onNext(ErrorWithCheck.email)
        } else if checkParams.checkPassword(password: password) == false {
            self.checked.onNext(ErrorWithCheck.passwordCount)
        } else if secondPassword != password {
            self.checked.onNext(ErrorWithCheck.secondPassword)
        } else {
            self.checked.onNext(ErrorWithCheck.ok)
        }
    }
}

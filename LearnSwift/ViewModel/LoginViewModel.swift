import Foundation
import RxSwift

class LoginViewModel {
    var dataModel: LoginModel?
    var error: PublishSubject<Bool> = PublishSubject()
    var data: PublishSubject<LoginRegistrationAccessModel> = PublishSubject()
    
    func postData(email: String, password: String) {
        APICaller.logIn(email: email, password: password) { result in
            switch result {
            case .success(let data):
                self.dataModel = data
                self.data.onNext(LoginRegistrationAccessModel(data: self.dataModel!))
            case .failure(_):
                self.error.onNext(true)
            }
        }
    }
}

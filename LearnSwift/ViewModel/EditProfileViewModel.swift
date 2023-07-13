import Foundation
import RxSwift

class EditProfileViewModel {
    var dataModel: EditProfileModel?
    
    var errorPassword: PublishSubject<Bool> = PublishSubject()
    var error: PublishSubject<Bool> = PublishSubject()
    
    var dataSource: PublishSubject<EditProfileAccessModel> = PublishSubject()
    
    func putData(name: String, password: String) {
        APICaller.putEditProfileData(name: name, password: password) { result in
            switch result {
            case .success(let data):
                self.dataModel = data
                self.dataSource.onNext(EditProfileAccessModel(data: self.dataModel!))
            case .failure(_):
                self.error.onNext(true)
            }
        }
    }
    
    func checkParams(pasword: String) {
        let checkParams = CheckRegister()
        if checkParams.checkPassword(password: pasword) == false {
            errorPassword.onNext(false)
        } else {
            errorPassword.onNext(true)
        }
    }
}

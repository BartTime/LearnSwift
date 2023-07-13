import Foundation
import RxSwift

class ProfileViewModel {
    var dataModel: ProfileModel?
    var dataSource: PublishSubject<SortedProfileDataModel> = PublishSubject()
    var dataSourceValue: SortedProfileDataModel?
    var goToEditProfile: PublishSubject<Bool> = PublishSubject()
    var goLogOut: PublishSubject<Bool> = PublishSubject()
    var error: PublishSubject<Bool> = PublishSubject()
    
    func numbersOfSection() -> Int {
        1
    }
    
    func numberOfRows() -> Int {
        return 4
    }
    
    func getTaskForUser() {
        APICaller.getTaskForProfile { [weak self] result in
            switch result {
            case .success(let data):
                self?.dataModel = data
                self?.sort(data: (self?.dataModel)!)
            case .failure(_):
                self?.error.onNext(true)
            }
        }
    }
    
    func sort(data: ProfileModel) {
        let sortedProfileData = SortedProfileDataModel()
        sortedProfileData.convertData(model: data)
        self.dataSourceValue = sortedProfileData
        self.dataSource.onNext(self.dataSourceValue!)
    }
    
    func logOut() {
        let defaults = UserDefaults.standard
        
        defaults.set("", forKey: "Password")
        defaults.set("", forKey: "Email")
        defaults.set(-1, forKey: "UserId")
        
        self.goLogOut.onNext(true)
    }
    
    func goToEditProfileFunc() {
        self.goToEditProfile.onNext(true)
    }
}

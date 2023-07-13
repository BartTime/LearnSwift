import Foundation

class LoginRegistrationAccessModel {
    let access_token: String
    let id: Int
    
    init(data: LoginModel) {
        self.access_token = data.access_token
        self.id = data.id
    }
}

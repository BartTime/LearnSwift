import Foundation

class EditProfileAccessModel {
    let access_token: String
    
    init(data: EditProfileModel) {
        self.access_token = data.access_token
    }
}

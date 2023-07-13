import Foundation

class ProfileModel: Codable {
    let tasks: [TaskForProfile]
    let user: User
}

class TaskForProfile: Codable {
    let id: Int
    let difficulty: Int
}

class User: Codable {
    let id: Int
    let name: String
    let tasks: [CompletedTask]
}

class CompletedTask: Codable {
    let id: Int
    let askForTasks: String
    let data: String
}

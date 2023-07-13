import Foundation

struct TaskModel: Codable {
    let tasks: [Task]
    let user: UsersTasks
}

struct Task: Codable {
    let condition: String
    let id: Int
    let name: String
    let requiredFunc: String
    let difficulty: Int
}

struct UsersTasks: Codable {
    let id: Int
    let name: String
    let tasks: [CompletedTaskForUser]
}
struct CompletedTaskForUser: Codable {
    let id: Int
    let askForTasks: String
    let data: String
}

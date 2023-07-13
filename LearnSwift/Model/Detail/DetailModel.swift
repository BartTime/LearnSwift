import Foundation

struct DetailModel: Codable {
    let task: [SomeTask]
}

struct SomeTask: Codable {
    let condition: String
    let id: Int
    let name: String
    let requiredFunc: String
    let ask: String?
    let examples: [Example]
    let tests: [Test]
}

struct Example: Codable {
    let description: String
}

struct Test: Codable {
    let answer: String
    let taskTest: String
}


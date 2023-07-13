import Foundation

class SortedProfileDataModel {
    var name: String
    var easyDifficultTaskAll: Int
    var completedEasyDifficultTask: Int
    var mediumDifficultTaskAll: Int
    var completedMediumDifficultTask: Int
    var hardDifficultTaskAll: Int
    var completedHardDifficultTask: Int
    var allCompletedTasks: Int
    var persentsOfEasyTasks: Float
    var persentsOfMediumTasks: Float
    var persentsOfHardTasks: Float
    var sumAllTasks: Float
    var completedTasksDate: [PerformanceModel] = []
    
    init() {
        self.name = ""
        self.easyDifficultTaskAll = 0
        self.completedEasyDifficultTask = 0
        self.mediumDifficultTaskAll = 0
        self.completedMediumDifficultTask = 0
        self.hardDifficultTaskAll = 0
        self.completedHardDifficultTask = 0
        self.allCompletedTasks = 0
        self.persentsOfEasyTasks = 0.0
        self.persentsOfMediumTasks = 0.0
        self.persentsOfHardTasks = 0.0
        self.sumAllTasks = 0.0
    }
    
    func convertData(model: ProfileModel) {
        let allDificulty = self.getDifficultyAllTasks(tasks: model.tasks)
        let completedDifficulty = self.getCompletedTask(tasks: model.tasks, userTasks: model.user.tasks)
        
        self.name = model.user.name
        self.easyDifficultTaskAll = allDificulty["easy"] ?? 0
        self.completedEasyDifficultTask = completedDifficulty["easy"] ?? 0
        self.mediumDifficultTaskAll = allDificulty["medium"] ?? 0
        self.completedMediumDifficultTask = completedDifficulty["medium"] ?? 0
        self.hardDifficultTaskAll = allDificulty["hard"] ?? 0
        self.completedHardDifficultTask = completedDifficulty["hard"] ?? 0
        self.allCompletedTasks = completedEasyDifficultTask + completedMediumDifficultTask + completedHardDifficultTask
        
        if easyDifficultTaskAll == 0 {
            self.persentsOfEasyTasks = 0.0
        } else {
            self.persentsOfEasyTasks = Float(completedEasyDifficultTask)/Float(easyDifficultTaskAll)
        }
        if mediumDifficultTaskAll == 0 {
            self.persentsOfMediumTasks = 0.0
        } else {
            self.persentsOfMediumTasks = Float(completedMediumDifficultTask)/Float(mediumDifficultTaskAll)
        }
        
        if hardDifficultTaskAll == 0 {
            self.persentsOfHardTasks = 0.0
        } else {
            self.persentsOfHardTasks = Float(completedHardDifficultTask)/Float(hardDifficultTaskAll)
        }
        
        sumAllTasks = Float((allDificulty["easy"] ?? 0) + (allDificulty["medium"] ?? 0) + (allDificulty["hard"] ?? 0))
        
        self.completedTasksDate = getCompleteDate(tasks: model.user.tasks)
    }
    
    private func getCompleteDate(tasks: [CompletedTask]) -> [PerformanceModel] {
        
        let rez: [PerformanceModel] = [
            .init(value: 0, title: "Jan"),
            .init(value: 0, title: "Feb"),
            .init(value: 0, title: "Mar"),
            .init(value: 0, title: "Apr"),
            .init(value: 0, title: "May"),
            .init(value: 0, title: "Jun"),
            .init(value: 0, title: "Jul"),
            .init(value: 0, title: "Aug"),
            .init(value: 0, title: "Sep"),
            .init(value: 0, title: "Okt"),
            .init(value: 0, title: "Nov"),
            .init(value: 0, title: "Dec")
        ]
        
        let time = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        let formatteddate = formatter.string(from: time as Date)
        for i in tasks {
            if i.data.contains(formatteddate) {
                let k = i.data.components(separatedBy: " ")
                if k[2] == "Jan" {
                    rez[0].value += 1
                } else if k[2] == "Feb" {
                    rez[1].value += 1
                } else if k[2] == "Mar" {
                    rez[2].value += 1
                } else if k[2] == "Apr" {
                    rez[3].value += 1
                } else if k[2] == "May" {
                    rez[4].value += 1
                } else if k[2] == "Jun" {
                    rez[5].value += 1
                } else if k[2] == "Jul" {
                    rez[6].value += 1
                } else if k[2] == "Aug" {
                    rez[7].value += 1
                } else if k[2] == "Sep" {
                    rez[8].value += 1
                } else if k[2] == "Okt" {
                    rez[9].value += 1
                } else if k[2] == "Nov" {
                    rez[10].value += 1
                } else if k[2] == "Dec" {
                    rez[11].value += 1
                }
            }
        }
        
        return rez
    }
    
    private func getDifficultyAllTasks(tasks: [TaskForProfile]) -> [String: Int] {
        var dict = ["easy": 0, "medium": 0, "hard": 0]
        
        for task in tasks {
            if task.difficulty == 0 {
                dict["easy"]! += 1
            } else if task.difficulty == 1 {
                dict["medium"]! += 1
            } else {
                dict["hard"]! += 1
            }
        }
        return dict
    }
    
    private func getCompletedTask(tasks: [TaskForProfile], userTasks: [CompletedTask]) -> [String: Int] {
        var dict = ["easy": 0, "medium": 0, "hard": 0]
        
        var easyTask = [Int]()
        var hardTask = [Int]()
        var mediumTask = [Int]()
        
        for task in tasks {
            if task.difficulty == 0 {
                easyTask.append(task.id)
            } else if task.difficulty == 1 {
                mediumTask.append(task.id)
            } else {
                hardTask.append(task.id)
            }
        }
        
        for userTask in userTasks {
            if easyTask.contains(userTask.id) {
                dict["easy"]! += 1
            } else if mediumTask.contains(userTask.id) {
                dict["medium"]! += 1
            } else if hardTask.contains(userTask.id) {
                dict["hard"]! += 1
            }
        }
        
        return dict
    }
    
}

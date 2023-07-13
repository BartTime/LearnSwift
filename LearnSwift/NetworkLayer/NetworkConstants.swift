import Foundation

class NetworkConstants {
    public static var shared: NetworkConstants = NetworkConstants()
    
    private init() { }
    
    public var serverAddress: String {
        get {
            return "http://185.225.34.191:5000/"
//            return "http://127.0.0.1:5000/"
        }
    }
    
    public var requestGetTasks: String {
        get {
            return "tasks"
        }
    }
    
    public var requestGetTask: String {
        get {
            return "task/"
        }
    }
    
    public var login: String {
        get {
            return "login"
        }
    }
    
    public var register: String {
        get {
            return "register"
        }
    }
    
    public var getTasksForUser: String {
        get {
            return "getTasksForUser"
        }
    }
    
    public var putEditProfile: String {
        get {
            return "updateUserData"
        }
    }
    
    public var postAskForTask: String {
        get {
            return "askForTask"
        }
    }
}

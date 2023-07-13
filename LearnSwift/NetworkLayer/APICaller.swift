import Foundation

enum NetworkError: Error {
    case urlError
    case canNotParseData
}

public class APICaller {
    static func getTasks(
        completionHandler: @escaping(_ result: Result<TaskModel, NetworkError>) -> Void
    ) {
        let defaults = UserDefaults.standard
        
        let urlString = NetworkConstants.shared.serverAddress + NetworkConstants.shared.requestGetTasks
        
        guard let url = URL(string: urlString) else { return completionHandler(.failure(.urlError)) }
        
        let jwtToken = defaults.string(forKey: "JWTToken") ?? ""
        
        var request = URLRequest(url: url)
        
        request.setValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return completionHandler(.failure(.canNotParseData))
            }
            
            guard let data = data else {
                return completionHandler(.failure(.canNotParseData))
            }
            
            do {
                let resultData = try JSONDecoder().decode(TaskModel.self, from: data)
                completionHandler(.success(resultData))
            } catch {
                completionHandler(.failure(.canNotParseData))
            }
            
        }.resume()
    }
    
    static func getSomeTask(
        id: String,
        completionHandler: @escaping(_ result: Result<DetailModel, NetworkError>) ->
        Void
    ) {
        let defaults = UserDefaults.standard
        
        let userid = defaults.integer(forKey: "UserId")
        
        let urlString = NetworkConstants.shared.serverAddress + NetworkConstants.shared.requestGetTask + id + "/\(userid)"
        
        guard let url = URL(string: urlString) else {
            return completionHandler(.failure(.urlError))
        }
        
        let jwtToken = defaults.string(forKey: "JWTToken") ?? ""
        
        var request = URLRequest(url: url)
        
        request.setValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return completionHandler(.failure(.canNotParseData))
            }
            
            guard let data = data else {
                return completionHandler(.failure(.canNotParseData))
            }
            
            do {
                let resultData = try JSONDecoder().decode(DetailModel.self, from: data)
                completionHandler(.success(resultData))
            } catch {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    static func getTaskForProfile(
        completionHandler: @escaping(_ result: Result<ProfileModel, NetworkError>) ->
        Void) {
            
            let defaults = UserDefaults.standard
            let id = defaults.integer(forKey: "UserId")
            
            let urlString = NetworkConstants.shared.serverAddress + NetworkConstants.shared.getTasksForUser + "/\(id)"
            
            guard let url = URL(string: urlString) else {
                return completionHandler(.failure(.urlError))
            }
            
            let jwtToken = defaults.string(forKey: "JWTToken") ?? ""
            
            var request = URLRequest(url: url)
            
            request.setValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
            request.setValue("*/*", forHTTPHeaderField: "Accept")
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    return completionHandler(.failure(.canNotParseData))
                }
                
                guard let data = data else {
                    return completionHandler(.failure(.canNotParseData))
                }
                
                do {
                    let resultData = try JSONDecoder().decode(ProfileModel.self, from: data)
                    completionHandler(.success(resultData))
                } catch {
                    completionHandler(.failure(.canNotParseData))
                }
            }.resume()
        }
    
    static func logIn(
        email: String,
        password: String,
        completionHandler: @escaping(_ result: Result<LoginModel, NetworkError>) -> Void
    ) {
        let urlString = NetworkConstants.shared.serverAddress + NetworkConstants.shared.login
        guard let url = URL(string: urlString) else {
            return completionHandler(.failure(.urlError))
        }
        
        let body: [String: Any] = ["email": email, "password": password]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return completionHandler(.failure(.urlError)) }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return completionHandler(.failure(.canNotParseData))
            }
            
            guard let data = data else {
                return completionHandler(.failure(.canNotParseData))
            }
            
            do {
                let resultData = try JSONDecoder().decode(LoginModel.self, from: data)
                completionHandler(.success(resultData))
            } catch {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    static func register(
        name: String,
        email: String,
        password: String,
        completionHandler: @escaping(_ result: Result<LoginModel, NetworkError>) -> Void
    ) {
        let urlString = NetworkConstants.shared.serverAddress + NetworkConstants.shared.register
        guard let url = URL(string: urlString) else {
            return completionHandler(.failure(.urlError))
        }
        let body: [String: Any] = ["name": name, "email": email, "password": password]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return completionHandler(.failure(.urlError))}
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return completionHandler(.failure(.canNotParseData))
            }
            
            guard let data = data else {
                return completionHandler(.failure(.canNotParseData))
            }
            
            do {
                let resultData = try JSONDecoder().decode(LoginModel.self, from: data)
                completionHandler(.success(resultData))
            } catch {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    
    static func getTaskForMainVC(
        completionHandler: @escaping(_ result: Result<TaskModel, NetworkError>) ->
        Void
    ) {
        let defaults = UserDefaults.standard
        let id = defaults.integer(forKey: "UserId")
        
        let urlString = NetworkConstants.shared.serverAddress + NetworkConstants.shared.getTasksForUser + "/\(id)"
        
        guard let url = URL(string: urlString) else {
            return completionHandler(.failure(.urlError))
        }
        
        let jwtToken = defaults.string(forKey: "JWTToken") ?? ""
        
        var request = URLRequest(url: url)
        
        request.setValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return completionHandler(.failure(.canNotParseData))
            }
            
            guard let data = data else {
                return completionHandler(.failure(.canNotParseData))
            }
            
            do {
                let resultData = try JSONDecoder().decode(TaskModel.self, from: data)
                completionHandler(.success(resultData))
            } catch {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    static func putEditProfileData(
        name: String,
        password: String,
        completionHandler: @escaping(_ result: Result<EditProfileModel, NetworkError>) -> Void
    ) {
        let defaults = UserDefaults.standard
        let id = defaults.integer(forKey: "UserId")
        
        let urlString = NetworkConstants.shared.serverAddress + NetworkConstants.shared.putEditProfile + "/\(id)"
        
        guard let url = URL(string: urlString) else {
            return completionHandler(.failure(.urlError))
        }
        
        let body: [String: Any] = ["name": name, "password": password]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return completionHandler(.failure(.urlError))}
        
        let jwtToken = defaults.string(forKey: "JWTToken") ?? ""
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "PUT"
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return completionHandler(.failure(.canNotParseData))
            }
            
            guard let data = data else {
                return completionHandler(.failure(.canNotParseData))
            }
            
            do {
                let resultData = try JSONDecoder().decode(EditProfileModel.self, from: data)
                completionHandler(.success(resultData))
            } catch {
                completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
    
    static func postAskForTask(
        ask: String,
        task: Int,
        completionHandler: @escaping(_ result: Result<AskForTaskModel, NetworkError>) -> Void
    ) {
        let defaults = UserDefaults.standard
        let id = defaults.integer(forKey: "UserId")
        
        let urlString = NetworkConstants.shared.serverAddress + NetworkConstants.shared.postAskForTask
        
        guard let url = URL(string: urlString) else {
            return completionHandler(.failure(.urlError))
        }
        
        let body: [String: Any] = ["user": id, "task": task, "ask": ask]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: body, options: []) else { return completionHandler(.failure(.urlError)) }
        
        let jwtToken = defaults.string(forKey: "JWTToken") ?? ""
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("*/*", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "POST"
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return completionHandler(.failure(.canNotParseData))
            }
            
            guard let data = data else {
                return completionHandler(.failure(.canNotParseData))
            }
            
            do {
                let resultData = try JSONDecoder().decode(AskForTaskModel.self, from: data)
                return completionHandler(.success(resultData))
            } catch {
                return completionHandler(.failure(.canNotParseData))
            }
        }.resume()
    }
}

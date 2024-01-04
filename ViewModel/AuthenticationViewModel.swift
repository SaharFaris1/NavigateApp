
import Foundation
import SwiftUI

class AuthenticationViewModel: ObservableObject{
    @Published var user: AuthenticationModel?
    
    func signUp(email: String, password: String){
        
        let parameters = "{\n  \"email\": \"\(email)\",\n  \"password\": \"\(password)\"\n}"
        let postData = parameters.data(using: .utf8)
        var request = URLRequest(url: URL(string: "https://npxvlreitylflxhdavqh.supabase.co/auth/v1/signup")!,timeoutInterval: Double.infinity)
        request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5weHZscmVpdHlsZmx4aGRhdnFoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI5ODAwNjMsImV4cCI6MjAxODU1NjA2M30.ZJgOnqx055yKb3jh8lmy4vLRYbUgjaGDu4KvzV6lHnk", forHTTPHeaderField: "apikey")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
        }

        task.resume()

    }
    func signIn(email: String, password: String){
        
        let parameters = "{\n  \"email\": \"\(email)\",\n  \"password\": \"\(password)\"\n}"


        let postData = parameters.data(using: .utf8)


        var request = URLRequest(url: URL(string: "https://npxvlreitylflxhdavqh.supabase.co/auth/v1/token?grant_type=password")!,timeoutInterval: Double.infinity)
        request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5weHZscmVpdHlsZmx4aGRhdnFoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI5ODAwNjMsImV4cCI6MjAxODU1NjA2M30.ZJgOnqx055yKb3jh8lmy4vLRYbUgjaGDu4KvzV6lHnk", forHTTPHeaderField: "apikey")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
        }

        task.resume()

        
    }
    
}

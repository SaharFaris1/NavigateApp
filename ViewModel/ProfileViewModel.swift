
import Foundation

class ProfileViewModel: ObservableObject{
    @Published var pro : [ProfileModel] = []
    
    init(){
        fetchProfile(id: UUID())
        fetchData()
    }
  
    
    
    func fetchData(){
        var request = URLRequest(url: URL(string: "https://npxvlreitylflxhdavqh.supabase.co/rest/v1/Profile?select=*")!,timeoutInterval: Double.infinity)
        request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5weHZscmVpdHlsZmx4aGRhdnFoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI5ODAwNjMsImV4cCI6MjAxODU1NjA2M30.ZJgOnqx055yKb3jh8lmy4vLRYbUgjaGDu4KvzV6lHnk", forHTTPHeaderField: "apikey")
        request.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5weHZscmVpdHlsZmx4aGRhdnFoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI5ODAwNjMsImV4cCI6MjAxODU1NjA2M30.ZJgOnqx055yKb3jh8lmy4vLRYbUgjaGDu4KvzV6lHnk", forHTTPHeaderField: "Authorization")

        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error with fetching data: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data,
               let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
                print("")
                DispatchQueue.main.sync {
                    let  decoder = JSONDecoder()
                    do{
                        self.pro = try decoder.decode([ProfileModel].self, from: data)
                        print(self.pro)
                        print("")
                    }
                    catch{
                        print("error\(error)")
                    }
                }
                
                
            }
            
            
        }
       
        task.resume()
    }
    //------------------------------------
   
    func fetchProfile(id: UUID){
        let url = URL(string: "https://npxvlreitylflxhdavqh.supabase.co/rest/v1/Profile?\(id)=eq.1&select=*")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5weHZscmVpdHlsZmx4aGRhdnFoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI5ODAwNjMsImV4cCI6MjAxODU1NjA2M30.ZJgOnqx055yKb3jh8lmy4vLRYbUgjaGDu4KvzV6lHnk", forHTTPHeaderField: "apikey")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5weHZscmVpdHlsZmx4aGRhdnFoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI5ODAwNjMsImV4cCI6MjAxODU1NjA2M30.ZJgOnqx055yKb3jh8lmy4vLRYbUgjaGDu4KvzV6lHnk", forHTTPHeaderField: "Authorization")
        request.addValue("0-9", forHTTPHeaderField: "Range")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
               guard error == nil else {
                   print("Error with fetching data: \(error!)")
                   return
               }

               guard let httpResponse = response as? HTTPURLResponse,
                     (200...299).contains(httpResponse.statusCode) else {
                   print("Error with the response, unexpected status code: \(String(describing: response))")
                   return
               }

               guard let data = data else {
                   print("No data received.")
                   return
               }

               do {
                   let decoder = JSONDecoder()
                   let pro = try decoder.decode([ProfileModel].self, from: data)

                   DispatchQueue.main.async {
                       self.pro = pro
                   }
               } catch {
                   print("Error decoding JSON: \(error)")
               }
           }
           
           task.resume()
       }
    //-----------------------------------
    func updateProfile(name: String , mobile: String){
        let parameters = "{ \"en_fullName\": \"\(name)\" }"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://npxvlreitylflxhdavqh.supabase.co/rest/v1/Profile?some_column=eq.someValue")!,timeoutInterval: Double.infinity)
        request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5weHZscmVpdHlsZmx4aGRhdnFoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI5ODAwNjMsImV4cCI6MjAxODU1NjA2M30.ZJgOnqx055yKb3jh8lmy4vLRYbUgjaGDu4KvzV6lHnk", forHTTPHeaderField: "apikey")
        request.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5weHZscmVpdHlsZmx4aGRhdnFoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI5ODAwNjMsImV4cCI6MjAxODU1NjA2M30.ZJgOnqx055yKb3jh8lmy4vLRYbUgjaGDu4KvzV6lHnk", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("return=minimal", forHTTPHeaderField: "Prefer")

        request.httpMethod = "PATCH"
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

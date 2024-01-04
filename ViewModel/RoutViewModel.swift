
import Foundation

class RoutViewModel: ObservableObject{
    @Published var route: [RouteModel] = []
    
    
    
    
    init(){
        fetchData()
    }
    func fetchData(){
        let url = URL(string: "https://npxvlreitylflxhdavqh.supabase.co/rest/v1/Route?select=*")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        
        request.setValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5weHZscmVpdHlsZmx4aGRhdnFoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI5ODAwNjMsImV4cCI6MjAxODU1NjA2M30.ZJgOnqx055yKb3jh8lmy4vLRYbUgjaGDu4KvzV6lHnk", forHTTPHeaderField: "apikey")
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5weHZscmVpdHlsZmx4aGRhdnFoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI5ODAwNjMsImV4cCI6MjAxODU1NjA2M30.ZJgOnqx055yKb3jh8lmy4vLRYbUgjaGDu4KvzV6lHnk", forHTTPHeaderField: "Authorization")
        
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
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let route = try decoder.decode([RouteModel].self, from: data)
                    
                    
                    DispatchQueue.main.async {
                        self.route = route
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }
        
        task.resume()
        
    }
}


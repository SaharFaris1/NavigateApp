

import Foundation
class ExploreViewModel: ObservableObject{
    @Published var explore: [ExploreModel] = []
    @Published var searchText = ""
    var filteredSearch: [ExploreModel] {
            if searchText.isEmpty {
                return explore
            } else {
                return explore.filter { model in
                    model.ar_placeName.localizedCaseInsensitiveContains(searchText) ||
                    model.en_placeName.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
    init(){
        fetchPlaces()
        
    }
    
    func fetchPlaces(){
        var request = URLRequest(url: URL(string: "https://npxvlreitylflxhdavqh.supabase.co/rest/v1/Places?select=*")!,timeoutInterval: Double.infinity)
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
                
                let  decoder = JSONDecoder()

                DispatchQueue.main.async {
                    do{
                        self.explore = try decoder.decode([ExploreModel].self, from: data)
                        print(self.explore)
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
    
    func addPlace(_ place: ExploreModel){
        let parameters = "{ \"some_column\": \"someValue\", \"other_column\": \"otherValue\" }"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "https://npxvlreitylflxhdavqh.supabase.co/rest/v1/Places")!,timeoutInterval: Double.infinity)
        request.addValue("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5weHZscmVpdHlsZmx4aGRhdnFoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI5ODAwNjMsImV4cCI6MjAxODU1NjA2M30.ZJgOnqx055yKb3jh8lmy4vLRYbUgjaGDu4KvzV6lHnk", forHTTPHeaderField: "apikey")
        request.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im5weHZscmVpdHlsZmx4aGRhdnFoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI5ODAwNjMsImV4cCI6MjAxODU1NjA2M30.ZJgOnqx055yKb3jh8lmy4vLRYbUgjaGDu4KvzV6lHnk", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("return=minimal", forHTTPHeaderField: "Prefer")

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


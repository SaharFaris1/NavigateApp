
import Foundation


struct RouteModel: Identifiable ,Codable{
    var id: UUID?
    var idFrom: Int
    var idTo: Int
    var path: String
    
}

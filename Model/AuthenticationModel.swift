
import Foundation

struct AuthenticationModel: Identifiable, Codable{
    var id = UUID()
    var email: String
    var password: String
}

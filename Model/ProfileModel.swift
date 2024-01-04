
import Foundation
struct ProfileModel: Identifiable, Codable{
    var id : UUID?
    var user_id: UUID?
    var en_fullName: String
    var mobile: String
    var ar_fullName: String
    var email: String
}


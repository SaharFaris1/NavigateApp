
import Foundation

struct CardInfo: Identifiable, Codable {
    var id: UUID?
    var card_number: String
    var card_holder: String
    var expiry_date: Date?
    var cvv: String
}

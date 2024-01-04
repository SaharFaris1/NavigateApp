
import Foundation


struct NavigateModel: Identifiable, Codable{
    var id: UUID?
    var en_place_name: String
    var place_id: Int
    var place_type: String
    var ar_place_name: String
    var en_number_floor: String
    var ar_number_floor: String
    var place_image: String
}

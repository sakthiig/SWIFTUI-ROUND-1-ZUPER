
import Foundation

struct Job: Codable, Identifiable {
    let id: String
    let customer_name: String?
    let address: String
    let scheduled_at: String
    var status: String
    let notes: String?
}

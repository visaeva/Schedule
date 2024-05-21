import Foundation

struct TimeSlot: Identifiable {
    let id = UUID()
    let name: String
    let startTime: String
    let endTime: String
}

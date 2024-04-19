import Foundation

struct CarrierList: Hashable {
    var name: String
    var image: String
    var transfer: String?
    var departureTime: String
    var arrivalTime: String
    var travelTime: String
    var date: String
    
    init(name: String, image: String, transfer: String?, departureTime: String, arrivalTime: String, travelTime: String, date: String) {
        self.name = name
        self.image = image
        self.transfer = transfer
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.travelTime = travelTime
        self.date = date
    }
}


import Foundation

final class CarrierViewModel: ObservableObject {
    @Published var carrier: [CarrierList]
    @Published var filteredCarrier: [CarrierList]

    init() {
        let carrier1 = CarrierList(name: "РЖД", image: "rzhd", transfer: "С пересадкой в Костроме",departureTime: "22:30", arrivalTime: "08:15", travelTime: "20 часов", date: "14 января")
        let carrier2 = CarrierList(name: "ФГК", image: "fgk", transfer: nil, departureTime: "01:15", arrivalTime: "09:00", travelTime: "9 часов", date: "15 января")
        let carrier3 = CarrierList(name: "Урал логистика", image: "ural", transfer: nil, departureTime: "12:30", arrivalTime: "21:00", travelTime: "9 часов", date: "16 января")
        let carrier4 = CarrierList(name: "РЖД", image: "rzhd", transfer: "С пересадкой в Костроме", departureTime: "22:30", arrivalTime: "08:15", travelTime: "20 часов", date: "17 января")
        let carrier5 = CarrierList(name: "РЖД", image: "rzhd", transfer: "С пересадкой в Костроме", departureTime: "22:30", arrivalTime: "08:15", travelTime: "20 часов", date: "17 января")
        
        self.carrier = [carrier1, carrier2, carrier3, carrier4, carrier5]
        self.filteredCarrier = [carrier1, carrier2, carrier3, carrier4, carrier5]
    }
}

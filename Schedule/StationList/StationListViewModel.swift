import Foundation

class StationListViewModel: ObservableObject {
    @Published var station: [StationsList]
    
    init() {
        let station1 = StationsList(name: "Киевский вокзал")
        let station2 = StationsList(name: "Курский вокзал")
        let station3 = StationsList(name: "Ярославский вокзал")
        let station4 = StationsList(name: "Белорусский вокзал")
        let station5 = StationsList(name: "Савеловский вокзал")
        let station6 = StationsList(name: "Ленинградский вокзал")
   
        self.station = [station1, station2, station3, station4, station5, station6]
    }
}

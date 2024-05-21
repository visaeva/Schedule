import Foundation

final class CityListViewModel: ObservableObject {
    @Published var city: [CityList]
    
    init() {
        let city1 = CityList(name: "Москва")
        let city2 = CityList(name: "Санкт Петербург")
        let city3 = CityList(name: "Сочи")
        let city4 = CityList(name: "Горный воздух")
        let city5 = CityList(name: "Краснодар")
        let city6 = CityList(name: "Казань")
        let city7 = CityList(name: "Омск")
        
        self.city = [city1, city2, city3, city4, city5, city6, city7]
    }
}

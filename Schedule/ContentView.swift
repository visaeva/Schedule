import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
           // copyright()
            //  search()
            //sheduleOnStations()
            //   nearestStations()
            //  thread()
            //   settlement()
            //   carrier()
            // stationList()
        }
    }
    
    func nearestStations() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        let service = NearestStationsService(
            client: client,
            apikey: apiKey
        )
        Task {
            do {
                let stations = try await service.getNearestStations(lat:
                                                                        50.4516962252837, 
                                                                    lng: 40.1392928134917,
                                                                    distance: Int(24.74255931084455))
                print(stations)
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    func search() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        let service = SearchService (
            client: client,
            apikey: apiKey
        )
        Task {
            do {
                let result = try await service.getBetweenStations(from: "c146", to: "c213")
                print(result)
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    func thread() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = ThreadService(
            client: client,
            apikey: apiKey
        )
        Task {
            do {
                let thread = try await service.listOfStation(uid: "176YE_0_2")
                print(thread)
                
            } catch {
                print("Error fetching thread: \(error)")
            }
        }
    }
    func settlement() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = NearestSettlementService(
            client: client,
            apikey: apiKey
        )
        
        Task {
            do {
                let result = try await service.nearestSettelement(lat:54.106677, lng: 39.601726)
                print(result)
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    
    func carrier() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        let service = CarrierService(
            client: client,
            apikey: apiKey
        )
        
        Task {
            do {
                let thread = try await service.infoCarrier(code: "SU", system: .iata)
                print(thread)
            } catch {
                print("Error fetching thread: \(error)")
            }
        }
    }
    
    
    func sheduleOnStations() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        let service = ScheduleService(
            client: client,
            apikey: apiKey
        )
        Task {
            do {
                let stations = try await service.scheduleOnStation(station: "s9600213")
                print(stations)
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    func copyright() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        
        let service = CopyrightService(
            client: client,
            apikey: apiKey
        )
        Task {
            do {
                let result = try await service.copyrightService(format: "json")
                print(result)
                
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    func stationList() {
        let client = Client(
            serverURL: try! Servers.server1(),
            transport: URLSessionTransport()
        )
        let service = StationListService (
            client: client,
            apikey: apiKey
        )
        
        Task {
            do {
                let stationListResult = try await service.stationList()
                let data = try await Data(collecting: stationListResult, upTo: 100*1024*1024)
                print("Data completed: \(data.count)")
                let allStationsList = try JSONDecoder().decode(Components.Schemas.GetAllStations.self, from: data)
                print("AllStationsList: \(allStationsList)")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}

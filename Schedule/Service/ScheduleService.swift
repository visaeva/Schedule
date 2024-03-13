import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleOnStation = Components.Schemas.ScheduleResponse

protocol ScheduleServiceProtocol {
    func scheduleOnStation(station: String) async throws -> ScheduleOnStation
}

final class ScheduleService: ScheduleServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func scheduleOnStation(station: String) async throws -> ScheduleOnStation {
        
        let response = try await client.getScheduleOnStation(query: .init(
            apikey: apikey,
            station: station
            
        ))
        return try response.ok.body.json
    }
}

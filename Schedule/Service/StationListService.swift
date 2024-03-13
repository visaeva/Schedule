import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias StationList = Components.Schemas.GetAllStations

protocol StationListServiceProtocol {
    func stationList(format: Operations.stationList.Input.Query.formatPayload)  async throws -> HTTPBody
}

final class StationListService: StationListServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func stationList(format: Operations.stationList.Input.Query.formatPayload = .json) async throws -> HTTPBody {
        
        let response = try await client.stationList(query: .init(
            apikey: apikey,
            format: format
        ))
        return try response.ok.body.html
    }
}

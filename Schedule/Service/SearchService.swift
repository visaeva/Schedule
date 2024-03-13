import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias BetweenStations = Components.Schemas.SearchResponse

protocol SearchServiceProtocol {
    func getBetweenStations(from: String, to: String) async throws -> BetweenStations
}

final class SearchService: SearchServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getBetweenStations(from: String, to: String) async throws -> BetweenStations {
        let response = try await client.getBetweenStations(query: .init(
            apikey: apikey,
            from: from,
            to: to
            
        ))
        return try response.ok.body.json
    }
}

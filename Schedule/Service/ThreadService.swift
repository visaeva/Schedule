import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias ListOfStations = Components.Schemas.ThreadResponse

protocol ThreadServiceProtocol {
    func listOfStation(uid: String)  async throws -> ListOfStations
}

final class ThreadService: ThreadServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func listOfStation(uid: String) async throws -> ListOfStations {
        
        let response = try await client.listOfStations(query: .init(
            apikey: apikey,
            uid: uid
            
        ))
        
        return try response.ok.body.json
    }
}

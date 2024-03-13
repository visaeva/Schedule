import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias Copyright = Components.Schemas.Copyright

protocol CopyrightServiceProtocol {
    func copyrightService(format: String)  async throws -> Copyright
}

final class CopyrightService: CopyrightServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func copyrightService(format: String) async throws -> Copyright {
        
        let response = try await client.copyright(query: .init(
            apikey: apikey,
            format: format
        ))
        return try response.ok.body.json
    }
}

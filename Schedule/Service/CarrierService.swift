import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias InfoCarrier = Components.Schemas.ListOfCarrier

protocol CarrierServiceProtocol {
    func infoCarrier(code: String, system: Operations.infoCarrier.Input.Query.systemPayload)  async throws -> InfoCarrier
}

final class CarrierService: CarrierServiceProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func infoCarrier(code: String, system: Operations.infoCarrier.Input.Query.systemPayload = .yandex) async throws -> InfoCarrier{
        
        let response = try await client.infoCarrier(query: .init(
            apikey: apikey,
            code: code,
            system: system
        ))
        return try response.ok.body.json
    }
}





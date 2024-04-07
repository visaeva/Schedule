import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

typealias NearestSettelement = Components.Schemas.NearestSettlementResponse

protocol NearestSettelementProtocol {
    func nearestSettelement(lat: Double, lng: Double)  async throws -> NearestSettelement
}

final class NearestSettlementService: NearestSettelementProtocol {
    private let client: Client
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func nearestSettelement(lat: Double, lng: Double)  async throws -> NearestSettelement {
        
        let response = try await client.nearestSettlement(query: .init(
            apikey: apikey,
            lat: lat,
            lng: lng
            
        ))
        return try response.ok.body.json
    }
}





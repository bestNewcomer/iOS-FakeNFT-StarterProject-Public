import Foundation

struct BasketRequest: NetworkRequest {
    
    var isUrlEncoded: Bool { false }
    var dto: Encodable?
    var httpMethod: HttpMethod
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/\(RequestConstants.order)")
    }
}
import Foundation

struct ProfileRequest: NetworkRequest {
    
    var isUrlEncoded: Bool { false }
    var putHeader: String?
    var dto: Encodable?
    var httpMethod: HttpMethod
    var endpoint: URL? {
        URL(string: "\(RequestConstants.baseURL)/\(RequestConstants.profile)")
    }
}

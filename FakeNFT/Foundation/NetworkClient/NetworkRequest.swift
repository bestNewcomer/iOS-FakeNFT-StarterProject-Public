import Foundation

enum HttpMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case delete = "DELETE"
}

protocol NetworkRequest {
  var endpoint: URL? { get }
  var httpMethod: HttpMethod { get }
  var dto: Encodable? { get }
  var token: String? { get }
  var isUrlEncoded: Bool { get }
}

// default values
extension NetworkRequest {
  var httpMethod: HttpMethod { .get }
  var dto: Encodable? { nil }
  var token: String? { Token.token }
  var isUrlEncoded: Bool { false }
}

enum Token {
  static let token = "107f0274-8faf-4343-b31f-c12b62673e2f"
}


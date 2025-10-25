import Foundation

public enum MimeType {
	public static let json = "application/json"
	public static let form = "application/x-www-form-urlencoded"
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol NetworkRequest {
    var endpoint: URL? { get }
    var httpMethod: HttpMethod { get }
    var dto: Data? { get }
	var contentType: String { get }
}

// default values
extension NetworkRequest {
    var httpMethod: HttpMethod { .get }
    var dto: Data? { nil }
	var contentType: String { MimeType.json }
}

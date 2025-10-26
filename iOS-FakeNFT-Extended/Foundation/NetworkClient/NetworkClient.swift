import Foundation

enum NetworkClientError: Error {
	case httpStatusCode(Int)
	case urlRequestError(any Error)
	case urlSessionError
	case parsingError
	case incorrectRequest(String)

    var errorMessage: String {
        switch self {
            case .httpStatusCode(let code):
                return "Ошибка сервера: \(code)"
            case .urlRequestError(let underlying):
                return "Ошибка соединения: \(underlying.localizedDescription)"
            case .urlSessionError:
                return "Отсутствует интернет-соединение"
            case .parsingError:
                return "Неверный формат данных"
            case .incorrectRequest(let message):
                return "Некорректный запрос: \(message)"
        }
    }
}

protocol NetworkClient: Sendable {
	func send(request: any NetworkRequest) async throws -> Data
	func send<T: Decodable>(request: any NetworkRequest) async throws -> T
}

final class DefaultNetworkClient: NetworkClient {
	private let session: URLSession
	private let decoder: JSONDecoder
	private let encoder: JSONEncoder

	init(
		session: URLSession = URLSession.shared,
		decoder: JSONDecoder = JSONDecoder(),
		encoder: JSONEncoder = JSONEncoder()
	) {
		self.session = session
		self.decoder = decoder
		self.encoder = encoder
	}

	func send(request: any NetworkRequest) async throws -> Data {
		let urlRequest = try create(request: request)
		let (data, response) = try await session.data(for: urlRequest)
		guard let response = response as? HTTPURLResponse else {
			throw NetworkClientError.urlSessionError
		}
		print(response.statusCode)
		guard 200 ..< 300 ~= response.statusCode else {
			throw NetworkClientError.httpStatusCode(response.statusCode)
		}
		return data
	}

	func send<T: Decodable>(request: any NetworkRequest) async throws -> T {
		let data = try await send(request: request)
		return try await parse(data: data)
	}

	// MARK: - Private

	private func create(request: any NetworkRequest) throws -> URLRequest {
		guard let endpoint = request.endpoint else {
			throw NetworkClientError.incorrectRequest("Empty endpoint")
		}

		var urlRequest = URLRequest(url: endpoint)
		urlRequest.httpMethod = request.httpMethod.rawValue
		urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")

		if let dto = request.dto {
			urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
			urlRequest.httpBody = dto
		}
		urlRequest.addValue(RequestConstants.token, forHTTPHeaderField: "X-Practicum-Mobile-Token")

		return urlRequest
	}

	private func parse<T: Decodable>(data: Data) async throws -> T {
		do {
			return try decoder.decode(T.self, from: data)
		} catch {
			throw NetworkClientError.parsingError
		}
	}
}

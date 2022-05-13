//
//  NetworkService.swift
//  Telescope
//
//  Created by Rob Whitaker on 24/04/2022.
//

import Foundation

enum HTTPStatus {
    case success(Int),
         clientError(Int),
         serverError(Int),
         other(Int),
         unknown

    init(_ status: Int) {
        switch status {
        case 200 ... 299:
            self = .success(status)
        case 400 ... 499:
            self = .clientError(status)
        case 500 ... 599:
            self = .serverError(status)
        default:
            self = .other(status)
        }
    }
}

enum HTTPMethod: String {
    case GET, POST
}

enum HTTPError: Error {
    case invalidURL,
         noResponse,
         errorResponse(HTTPStatus)
}

protocol NetworkService {
    associatedtype DecodableModel: Decodable
    var method: HTTPMethod { get }
    var url: String { get }
}

enum NetworkSession {
    static let session = URLSession(configuration: .default)
}

extension NetworkService {

    func start() async -> (DecodableModel?, Error?) {
        guard let dataURL = URL(string: url) else { return (nil, HTTPError.invalidURL) }

        var data: Data
        var response: URLResponse

        await NetworkSession.session.allTasks.forEach {
            $0.cancel()
        }

        do {
            (data, response) = try await NetworkSession.session.data(from: dataURL)
        } catch {
            return (nil, error)
        }

        if data.isEmpty {
            return (nil, HTTPError.noResponse)
        }

        var status = HTTPStatus.unknown

        if let response = response as? HTTPURLResponse {
            status = HTTPStatus(response.statusCode)
        }

        guard case .success = status else {
            return (nil, HTTPError.errorResponse(status))
        }

        var model: DecodableModel

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601

        do {
            model = try decoder.decode(DecodableModel.self, from: data)
        } catch {
            return (nil, error)
        }

        return (model, nil)
    }
}

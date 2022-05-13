//
//  FetchImage.swift
//  Telescope
//
//  Created by Rob Whitaker on 26/04/2022.
//

import Foundation
import UIKit

final class FetchImage {
    static func fetchImage(url: String) async -> (UIImage?, Error?) {
        guard let imageURL = URL(string: url) else {
            return (nil, HTTPError.invalidURL)
        }

        var data: Data
        var response: URLResponse

        do {
            (data, response) = try await URLSession.shared.data(from: imageURL)
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

        if let image = UIImage(data: data) {
            return (image, nil)
        } else {
            return (nil, HTTPError.noResponse)
        }
    }
}

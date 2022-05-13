//
//  ImagesService.swift
//  Telescope
//
//  Created by Rob Whitaker on 26/04/2022.
//

import Foundation

final class SearchService: NetworkService {
    typealias DecodableModel = SearchResult

    var method: HTTPMethod = .GET
    var url: String {
        "https://images-api.nasa.gov/search?media_type=image&q=\(term)"
    }
    private let term: String

    init?(term: String) {
        guard let escpaedTerm = term.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        self.term = escpaedTerm
    }

}

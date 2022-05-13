//
//  SearchResult.swift
//  Telescope
//
//  Created by Rob Whitaker on 26/04/2022.
//

import Foundation

struct SearchResult: Codable {
    let collection: Collection
}

struct Collection: Codable {
    let items: [PhotoData]
}

struct PhotoData: Codable {
    let data: [Datum]
    let links: [Link]
}

struct Datum: Codable {
    let datumDescription: String?
    let title: String
    let nasaID: String
    let dateCreated: Date
    let keywords: [String]?
    let center: String?

    enum CodingKeys: String, CodingKey {
        case datumDescription = "description"
        case title
        case nasaID = "nasa_id"
        case dateCreated = "date_created"
        case keywords
        case center
    }
}

struct Link: Codable {
    let href: String
    var urlEncodedHref: String? {
        href.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    let rel: String
    let render: String?
}

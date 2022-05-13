//
//  ImageItem.swift
//  Telescope
//
//  Created by Rob Whitaker on 01/05/2022.
//

import Foundation
import UIKit

struct ImageItem: Codable, Hashable, Identifiable {

    var id: String { nasaID }
    let imageURLString: String
    var imageURL: URL? { URL(string: imageURLString) }
    let title: String
    let description: String?
    let center: String?
    let date: Date
    let nasaID: String
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        let formattedDate = dateFormatter.string(from: self.date)
        return formattedDate
    }
    var liked: Bool
}

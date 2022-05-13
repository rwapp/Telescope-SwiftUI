//
//  FavouriteStorage.swift
//  Telescope
//
//  Created by Rob Whitaker on 02/05/2022.
//

import Foundation

extension NSNotification.Name {
    static let favouritesChanged = NSNotification.Name("favouritesChanged")
}

struct Favourites {
    static var favourites: [ImageItem] {
        get {
            load()
        }
        set {
            save(newValue)
        }
    }

    private static let filename = getDocumentsDirectory().appendingPathComponent("favourites.json")

    private static func load() -> [ImageItem] {
        do {
            let data = try Data(contentsOf: filename)
            let json = try JSONDecoder().decode([ImageItem].self, from: data)
            return json
        } catch {
            print(error.localizedDescription)
        }

        return []
    }

    private static func save(_ favourites: [ImageItem]) {
        do {
            let json = try JSONEncoder().encode(favourites)
            try json.write(to: filename)
            NotificationCenter.default.post(name: .favouritesChanged, object: nil)
        } catch {
            print(error.localizedDescription)
        }
    }

    private static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

final class FavouriteStorage {
    private let favourites = Favourites()

    func isFavourite(image: ImageItem) -> Bool {
        Favourites.favourites.contains(image)
    }

    func setFavourite(_ favourite: Bool, image: ImageItem) {
        if favourite {
            Favourites.favourites.append(image)
        } else {
            Favourites.favourites = Favourites.favourites.filter { $0 != image }
        }
    }

    func allFavourites() -> [ImageItem] {
        return Favourites.favourites
    }
}

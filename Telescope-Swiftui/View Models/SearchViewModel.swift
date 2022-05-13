//
//  SearchViewModel.swift
//  Telescope-Swiftui
//
//  Created by Rob Whitaker on 08/05/2022.
//

import Foundation

final class SearchViewModel: ObservableObject {
    @Published private(set) var imageItems = [ImageItem]()

    func search(_ term: String) {

        guard term.count > 0,
              let searchService = SearchService(term: term) else {
            return
        }

        Task {
            let (results, error) = await searchService.start()

            if error != nil {
                print(String(describing: error?.localizedDescription))
                return
            }

            await MainActor.run { [weak self] in
                self?.imageItems = results?.collection.items
                    .filter { !$0.links.isEmpty && !$0.data.isEmpty && $0.links.first?.urlEncodedHref != nil }
                    .map {
                        ImageItem(imageURLString: $0.links.first!.urlEncodedHref!,
                                  title: $0.data.first!.title,
                                  description: $0.data.first?.datumDescription,
                                  center: $0.data.first?.center,
                                  date: $0.data.first!.dateCreated,
                                  nasaID: $0.data.first!.nasaID,
                                  liked: Bool.random())
                    } ?? []
            }
        }
    }
}

//
//  SearchView.swift
//  Telescope-Swiftui
//
//  Created by Rob Whitaker on 08/05/2022.
//

import SwiftUI

struct SearchView: View {

    @State private var query = ""
    @Namespace private var customRotorNamespace

    @ObservedObject private var viewModel: SearchViewModel

    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            Group {
                if query.count > 0 {
                    ScrollViewReader { scrollView in
                        ScrollView {
                            LazyVStack {
                                ForEach(viewModel.imageItems) { item in
                                    ImageCell(imageItem: item)
                                        .accessibilityElement(children: .combine)
                                        .accessibilityAddTraits(.isButton)
                                        .accessibilityAddTraits(.isImage)
                                        .accessibilityValue(item.liked ? "Liked" : "")
                                        .accessibilityRotorEntry(id: item.id, in: customRotorNamespace)
                                        .id(item.id)
                                }
                                .accessibilityRotor("Liked") {
                                    ForEach(viewModel.imageItems, id: \.id) { item in
                                        if item.liked {
                                            AccessibilityRotorEntry(item.title, item.id, in: customRotorNamespace) {
                                                scrollView.scrollTo(item.id)
                                            }
                                        }
                                    }
                                }
                                .padding(8)
                            }
                        }
                    }
                } else {
                    Text("\(Image(systemName: "globe.americas.fill")) Search for NASA images \(Image(systemName: "arrow.up"))")
                        .font(.title)
                        .accessibilityLabel("Search for NASA images")
                }
            }
            .navigationBarTitle("Telescope", displayMode: .inline)
        }
        .searchable(text: $query)
        .onChange(of: query) { newValue in
            viewModel.search(query)
        }
    }
}

//
//  ImageDetail.swift
//  Telescope-Swiftui
//
//  Created by Rob Whitaker on 09/05/2022.
//

import SwiftUI

class ShowViewer: ObservableObject {
    @Published var show = false
}

struct ImageDetail: View {

    private let imageItem: ImageItem

    @StateObject var showLargeImageViewer = ShowViewer()

    init(imageItem: ImageItem) {
        self.imageItem = imageItem
    }

    var body: some View {

        if showLargeImageViewer.show {
            ImageViewer(imageItem: imageItem)
                .accessibilityAddTraits(.isModal)
                .environmentObject(showLargeImageViewer)

        } else {
            ScrollView {
                VStack {
                    Button {
                        showLargeImageViewer.show.toggle()
                    } label: {
                        AsyncImage(url: imageItem.imageURL!) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .accessibilityHidden(false)
                                .accessibilityLabel(imageItem.title)

                        } placeholder: {
                            Color(UIColor.systemGray6)
                        }
                        .frame(height: UIScreen.main.bounds.height / 2)
                        .clipped()
                    }

                    ImageButtons(imageItem: imageItem)
                        .padding(8)

                    Text(imageItem.title)
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 4)

                    Text(imageItem.dateString)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 8)
                        .padding(.bottom, 4)

                    if let description = imageItem.description {
                        Text(description)
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 8)
                            .padding(.bottom, 4)
                    }

                    if let center = imageItem.center {
                        Text("NASA center: \(center)")
                            .font(.body)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 8)
                            .padding(.bottom, 4)

                        Spacer()
                    }
                }
            }
            .navigationBarTitle(imageItem.title, displayMode: .inline)
        }
    }
}

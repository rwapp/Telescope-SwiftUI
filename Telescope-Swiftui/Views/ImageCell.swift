//
//  ImageCell.swift
//  Telescope-Swiftui
//
//  Created by Rob Whitaker on 09/05/2022.
//

import SwiftUI

struct ImageCell: View {
    
    private let imageItem: ImageItem
    @State private var image: Image?

    init(imageItem: ImageItem) {
        self.imageItem = imageItem
    }

    var body: some View {
        VStack(spacing: 8) {
            NavigationLink(destination: ImageDetail(imageItem: imageItem)) {

                AsyncImage(url: imageItem.imageURL!) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .accessibilityHidden(false)
                        .accessibilityLabel(imageItem.title)

                } placeholder: {
                    Color(UIColor.systemGray6)
                }
                .frame(height: UIScreen.main.bounds.height / 3)
                .clipped()
            }
            .accessibilityAddTraits(.isImage)

            ImageButtons(imageItem: imageItem)

            Text(imageItem.title)
                .font(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

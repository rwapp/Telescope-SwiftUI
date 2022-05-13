//
//  ImageButtons.swift
//  Telescope-Swiftui
//
//  Created by Rob Whitaker on 09/05/2022.
//

import SwiftUI

struct ImageButtons: View {
    @State var imageItem: ImageItem

    var body: some View {
        HStack(spacing: 8) {
            Button {
                imageItem.liked.toggle()
            } label: {
                Image(systemName: imageItem.liked ? "heart.fill" : "heart")
                    .foregroundColor(.red)
            }
            .accessibilityLabel(imageItem.liked ? "Liked" : "Like")

            Button {
                // TODO: perform share
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(.red)
            }
            .accessibilityLabel("Share")

            Button {
                // TODO: perform save
            } label: {
                Image(systemName: "square.and.arrow.down")
                    .foregroundColor(.red)
            }
            .accessibilityLabel("Save")

            Spacer()
        }
    }
}

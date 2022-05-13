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
            if imageItem.liked {
                Button {
                    imageItem.liked.toggle()
                } label: {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                }
                .accessibilityLabel("Liked")
                .accessibilityAddTraits(.isSelected)

            } else {
                Button {
                    imageItem.liked.toggle()
                } label: {
                    Image(systemName: "heart")
                        .foregroundColor(.red)
                }
                .accessibilityLabel("Like")
            }

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

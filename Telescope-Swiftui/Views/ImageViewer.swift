//
//  ImageViewer.swift
//  Telescope-Swiftui
//
//  Created by Rob Whitaker on 09/05/2022.
//

import SwiftUI

struct ImageViewer: View {
    private let imageItem: ImageItem

    @State var scrollContentZoom: CGFloat = 1
    @GestureState var scrollContentGestureZoom: CGFloat = 1
    var contentZoom: CGFloat { scrollContentZoom * scrollContentGestureZoom }
    @EnvironmentObject var showViewer: ShowViewer

    init(imageItem: ImageItem) {
        self.imageItem = imageItem
    }

    var body: some View {
        AsyncImage(url: imageItem.imageURL!) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .accessibilityHidden(false)
                .accessibilityLabel(imageItem.title)

        } placeholder: {
            Color(UIColor.systemGray6)
        }
        .frame(width: UIScreen.main.bounds.width,
               height: UIScreen.main.bounds.height)
        .clipped()
        .gesture(MagnificationGesture()
            .updating($scrollContentGestureZoom) { (state, gestureState, _) in
                if state <=  0.65 {
                    showViewer.show = false
                }
                gestureState = state
            }
            .onEnded { (state) in
                scrollContentZoom = contentZoom * state
            })
        .scaleEffect(scrollContentZoom)

    }
}

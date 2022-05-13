//
//  Telescope_SwiftuiApp.swift
//  Telescope-Swiftui
//
//  Created by Rob Whitaker on 08/05/2022.
//

import SwiftUI

@main
struct Telescope_SwiftuiApp: App {
    var body: some Scene {
        WindowGroup {
            SearchView(viewModel: SearchViewModel())
        }
    }
}

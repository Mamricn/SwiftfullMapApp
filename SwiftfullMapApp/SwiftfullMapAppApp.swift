//
//  SwiftfullMapAppApp.swift
//  SwiftfullMapApp
//
//  Created by Marcin Turek on 28/04/2025.
//

import SwiftUI

@main




struct SwiftfullMapAppApp: App {
    @StateObject var vm = LocationsViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(LocationsViewModel())
        }
    }
}

//
//  SwiftfullMapAppApp.swift
//  SwiftfullMapApp
//
//  Created by Marcin Turek on 28/04/2025.
//

import SwiftUI

@main
struct SwiftfullMapAppApp: App {
    
    @State private var vm = LocationsViewModel()
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}

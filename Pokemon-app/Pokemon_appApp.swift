//
//  Pokemon_appApp.swift
//  Pokemon-app
//
//  Created by rafa mercado on 4/8/26.
//

import SwiftUI

@main
struct Pokemon_appApp: App {
    @State private var teamManager = TeamManager()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(teamManager)
        }
    }
}

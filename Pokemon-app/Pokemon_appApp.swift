//
//  Pokemon_appApp.swift
//  Pokemon-app
//
//  Created by rafa mercado on 4/8/26.
//

import SwiftUI

@main
struct PokemonAppApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false
    var teamManager = TeamManager()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(teamManager)
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

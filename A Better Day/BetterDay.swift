//
//  A_Better_DayApp.swift
//  A Better Day
//
//  Created by Jack Ferris on 5/28/25.
//

// importing necessary libraries
import SwiftUI
import SwiftData





@main
struct BetterDay: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .modelContainer(for: [Day.self, Thing.self])
        }
    }
}

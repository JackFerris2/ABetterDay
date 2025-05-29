//
//  HomeView.swift
//  A Better Day
//
//  Created by Jack Ferris on 5/28/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        
        TabView {
            // create tabs for the new views
            TodayView()
                .tabItem {
                    Text("Today")
                    Image(systemName: "calendar")
                }
            
            ThingsView()
                .tabItem {
                    Text("Things")
                    Image(systemName: "list.bullet")
                }
            
            RemindersView()
                .tabItem {
                    Text("Reminders")
                    Image(systemName: "bell")
                }
            
            SettingsView()
                .tabItem {
                    Text("Settings")
                    Image(systemName: "gearshape")
                }
        }
        // This will pad all of of our views 
        .padding()
        
    }
}

#Preview {
    HomeView()
}

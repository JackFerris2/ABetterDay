//
//  HomeView.swift
//  A Better Day
//
//  Created by Jack Ferris on 5/28/25.
//

import SwiftUI

struct HomeView: View {
    
    @State var selectedTab: Tab = Tab.today
    
    var body: some View {
        
        TabView (selection: $selectedTab) {
            
// create tabs for the new views
// sending as a binding to the today view
            TodayView(selectedTab: $selectedTab)
                .tabItem {
                    Text("Today")
                    Image(systemName: "calendar")
                }
                .tag(Tab.today)
            
            ThingsView()
                .tabItem {
                    Text("Things")
                    Image(systemName: "list.bullet")
                }
                .tag(Tab.things)
            
            RemindersView()
                .tabItem {
                    Text("Reminders")
                    Image(systemName: "bell")
                }
                .tag(Tab.reminders)
            
            SettingsView()
                .tabItem {
                    Text("Settings")
                    Image(systemName: "gearshape")
                }
                .tag(Tab.settings)
        }
        
// This will pad all of of our views
        
        .padding()
        
    }
}

// Added enum for tabs

enum Tab: Int {
    case today          = 0
    case things         = 1
    case reminders      = 2
    case settings       = 3
}


#Preview {
    HomeView()
}

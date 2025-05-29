//
//  TodayView.swift
//  A Better Day
//
//  Created by Jack Ferris on 5/28/25.
//

import SwiftUI
import SwiftData

struct TodayView: View {
    
    @Environment(\.modelContext) private var context
    
    // Adding state property to pass the TabView we created in the homeView
    @Binding var selectedTab: Tab
    
    @Query(filter: Day.currentDayPredicate(),
           sort: \.date) private var today: [Day]
    
    var body: some View {
        
        VStack(spacing: 20) {
            
            Text("  Today")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("  Try to do things that make you feel positve today.")
                .frame(maxWidth: .infinity, alignment: .leading)

            
// only display the list if there are things for today
            if getToday().things.count > 0 {
                List(getToday().things) { thing in
                    
                    Text(thing.title)
// Go through all the things they did today
// TODO: But first what is today
                }
                    .listStyle(.plain)

            }
            else {
// TODO: Display the image and tooltips
                 Spacer()
                Image("today")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300)
                                
                ToolTipView(text: "Take some time to do something that recharges you and makes you feel good about yourself. Hit the log button below to start! ") 
                
                Button {
                    // TODO: switch to things tab
                    selectedTab = Tab.things

                } label: {
                    Text("Log")
                }
                .buttonStyle(.borderedProminent)
                
                
                Spacer()
            }
            
            
        }
    }
    func getToday() -> Day {
             
// Try to retrive today fron the database
        if today.count > 0 {
            return today.first!
        }
        else  {
            let today = Day()
            context.insert(today)
            try? context.save()
            
            return today
        }
// if does not exist create a day and insert it!
        
        
    }
    
}

#Preview {
    TodayView(selectedTab: Binding.constant(Tab.today))
}

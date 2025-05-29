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
    
    @Query(filter: Day.currentDayPredicate(),
           sort: \.date) private var today: [Day]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            Text("Today")
                .font(.largeTitle)
                .bold()
            
            Text("Try to do things that make you feel positve today.")
            
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
    TodayView()
}

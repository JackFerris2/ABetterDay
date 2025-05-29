//
//  ThingView.swift
//  A Better Day
//
//  Created by Jack Ferris on 5/28/25.
//

import SwiftUI
import SwiftData

struct ThingsView: View {
    
    @Environment(\.modelContext) private var context
    
    @Query(filter: Day.currentDayPredicate(),
           sort: \.date) private var today: [Day]
    
    
    @Query(filter: #Predicate<Thing> { $0.isHidden == false } )
    private var things: [Thing]
    
    @State private var showAddView: Bool = false
    
    var body: some View {
        // add method to return the current day
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
        
        return VStack (spacing:20) {
                
                Text("Things")
                    .font(.largeTitle)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
            
                
                Text("These are the things that make you feel positive and uplifted!")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            
            if things.count == 0 {
                // Image
                Image("things")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300)
                
                // Image tooltip
                ToolTipView(text: "Start by adding things that brighten your day, tap the button below to get started!")
            } else {
                
                
                List (things) { thing in
                    
                    let today = getToday()
                    
                    HStack {
                        Text(thing.title)
                        Spacer()
                        
                        Button {
                            // Append the thing they tap to list of things done for the day
                            if today.things.contains(thing) {
                                // Remove things from today
                                today.things.removeAll {
                                    t in t == thing
                                }
                                try? context.save()
                            }
                            else {
                                // Add thing to today
                                today.things.append(thing)
                            }
                            
                            
                            
                        }
                        label : {
                            
                            // If this thing is already in todays list, show a solid check instead
                            if today.things.contains(thing) {
                                Image(systemName: "checkmark.circle.fill")
                                // changing the tint to blue
                                    .foregroundStyle(.blue)
                            }
                            else {
                                Image(systemName: "checkmark.circle")
                            }
                        }
                        
                    }
                }
                .listStyle(.plain)
            }
                Spacer()
                
                Button ("Add New Thing") {
                    // TODO: show sheet to add thing
                    showAddView.toggle()
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity,
                       alignment: .center)
                          
                Spacer()
            }
            .sheet(isPresented: $showAddView) {
                AddThingView()
                    .presentationDetents([.fraction(0.2)])
            }
    }
}

#Preview {
    ThingsView()
}

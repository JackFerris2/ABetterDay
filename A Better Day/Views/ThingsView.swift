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
            
// TODO: Try to retrive today fron the database
            if today.count > 0 {
                return today.first!
            }
            else  {
                let today = Day()
                context.insert(today)
                try? context.save()
                
                return today
            }
// TODO: if does not exist create a day and insert it!
            
            
        }
        
        return VStack (alignment: .leading, spacing:20) {
                
                Text("Things")
                    .font(.largeTitle)
                    .bold()
                
                Text("These are the things that make you feel positive and uplifted!")
                
                List (things) { thing in
                    
                    HStack {
                        Text(thing.title)
                        Spacer()
                        
                        Button {
// TODO: Add the thing to today
// TODO: Append the thing they tap to list of things done for the day
                            let today = getToday()
                            today.things.append(thing)
                        } label : {
                            Image(systemName: "checkmark.circle")
                        }
                        
                    }
                }
                .listStyle(.plain)
                
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

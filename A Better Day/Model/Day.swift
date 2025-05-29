//
//  Day.swift
//  A Better Day
//
//  Created by Jack Ferris on 5/28/25.
//

import Foundation
import SwiftData

@Model
class Day: Identifiable {
    @Attribute
    var id: String = UUID().uuidString
    @Attribute
    var date: Date = Date()
    @Attribute
    var things = [Thing]()
    
    init() {
        
    }
}
 
extension Day {
    
    static func currentDayPredicate() -> Predicate<Day> {
        
        let calendar = Calendar.autoupdatingCurrent
        let start = calendar.startOfDay(for: Date.now)
        
        return #Predicate <Day> { $0.date >= start }
        
    }
    
}

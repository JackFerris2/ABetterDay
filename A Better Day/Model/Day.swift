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

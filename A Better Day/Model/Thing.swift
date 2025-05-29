//
//  Thing.swift
//  A Better Day
//
//  Created by Jack Ferris on 5/28/25.
//

// File for the things that we will be adding that uplift your day

import Foundation
import SwiftData

// create a class
@Model
class Thing: Identifiable {
    // generates a unique random string
    var id: String = UUID().uuidString
    var title: String = ""
    var lastUpdated: Date = Date()
    var isHidden: Bool = false
    // initilizing  
    init(title: String) {
        self.title = title
    }
    
    
}

//
//  AddThingView.swift
//  A Better Day
//
//  Created by Jack Ferris on 5/28/25.
//

import SwiftUI
import SwiftData


struct AddThingView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var thingTitle = ""
    
    
    var body: some View {
        
        VStack (alignment: .leading, spacing: 10){
            
            TextField("What makes you feel good?",
                      text: $thingTitle)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Add") {
                //Add into swift data
                addThing()
                
                thingTitle = ""
                
                dismiss()
            }
            .buttonStyle(BorderedProminentButtonStyle())
            .disabled(thingTitle.trimmingCharacters(in: .whitespacesAndNewlines) .isEmpty)
        }
        .padding()
    }
    func addThing() {
    
        // clean the text
        let cleanedTitle =
        thingTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // TODO: add into DB
        context.insert(Thing(title: cleanedTitle))
        
        try? context.save
}

    
}

#Preview {
    AddThingView()
}

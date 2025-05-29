//
//  ToolTipView.swift
//  A Better Day
//
//  Created by Jack Ferris on 5/29/25.
//

import SwiftUI

struct ToolTipView: View {
    
    var text: String
    
    var body: some View {
        Text(text)
            .foregroundStyle(Color.blue)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(Color.blue, lineWidth: 1)
// adding light blue backround border in assets to box
                    .background(Color("light-blue"))
            }
    }
}

#Preview {
    ToolTipView(text: "Hello, World!")
}

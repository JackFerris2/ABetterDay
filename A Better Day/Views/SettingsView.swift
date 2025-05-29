//
//  SettingsView.swift
//  A Better Day
//
//  Created by Jack Ferris on 5/28/25.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    
    var body : some View {
        
        VStack (alignment: .leading, spacing: 20) {
            
            Text("  Settings")
                .font(.largeTitle)
                .bold()
            
            List {
                
                // Rate the app
                let reviewUrl = URL(string:
                "https://apps.apple.com/app")!
                
                Link(destination: reviewUrl, label: {
                    
                    HStack {
                        Image(systemName: "star.bubble")
                        Text("Rate the App")
                    }
                })
                
                // Reccomend the app
                let shareUrl = URL(string:
                                    "https://apps.apple.com/app")!
                
                ShareLink(item: shareUrl) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Share the App")
                    }
                }
                
                // Contact
                Button {
                    // compose email
                    let mailUrl = createMailUrl()
                    
                    if let mailUrl = mailUrl,
                       UIApplication.shared.canOpenURL(mailUrl) {
                        UIApplication.shared.open(mailUrl)
                    }
                    else {
                        print("Could not open mail client")
                    }
                } label: {
                    HStack {
                        Image(systemName: "quote.bubble")
                        Text("Submit Feedback")
                    }
                }
                
            }
        }
    }
    
}

// function for mail url
// TODO: finish function
    func createMailUrl() -> URL? {
    var mailUrlComponents = URLComponents()
        mailUrlComponents.scheme = "mailto"
        mailUrlComponents.host = "compose.mail.google.com"
        return mailUrlComponents.url
}



#Preview {
    SettingsView()
}

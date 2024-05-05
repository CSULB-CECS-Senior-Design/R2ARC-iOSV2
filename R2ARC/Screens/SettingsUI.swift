//
//  SettingsUI.swift
//  R2ARC
//
//  Created by Shane Lobsinger on 4/14/24.
//

import SwiftUI

struct SettingsUI: View {
    var body: some View {
        List {
            Button("Version Info") {
                // Action to show Version Info
                print("Version Info tapped")
            }
            Button("About Us") {
                // Action to show About Us
                print("About Us tapped")
            }
            Button("Legal") {
                // Action to show Legal
                print("Legal tapped")
            }
        }
        .navigationTitle("Settings")
    }
}

struct VersionInfoView: View {
    var body: some View {
        Text("App Version 1.0.0")
            .navigationBarTitle("Version Info", displayMode: .inline)
    }
}

struct AboutUsView: View {
    var body: some View {
        HStack {
            Spacer() // Adds a spacer on the left
            Text("We are Team 7, our project was produced by Kevin Martinez, Grecia Francisco, Michelle Tran, Jesus Perez, and Shane Lobsinger")
            Spacer() // Adds a spacer on the right
        }
        .navigationBarTitle("About Us", displayMode: .inline)
    }
}

struct LegalView: View {
    var body: some View {
        HStack {
            Spacer() // Adds a spacer on the left
            Text("This product is provided under the terms of this Non-Commercial Use License. The product is licensed only for personal, non-commercial use. Commerical use refers to any operation or activity where the primary intent is to generate revenue or business benefits. The user agrees not to use this product for any commercial purposes without prior written consent from Team 7 R2-ARC. Any unauthorized commercial use of this product will result in termination of this license and may subject the user to legal action.")
            Spacer() // Adds a spacer on the right
        }
        .navigationBarTitle("Legal", displayMode: .inline)
    }
}





struct SettingsUI_Previews: PreviewProvider {
    static var previews: some View {
        SettingsUI()
    }
}

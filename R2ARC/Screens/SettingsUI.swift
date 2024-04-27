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
        Text("We are Awesome App Inc., dedicated to making your life easier.")
            .navigationBarTitle("About Us", displayMode: .inline)
    }
}

struct LegalView: View {
    var body: some View {
        Text("All rights reserved. Your use of this service is subject to our Terms and Conditions.")
            .navigationBarTitle("Legal", displayMode: .inline)
    }
}




struct SettingsUI_Previews: PreviewProvider {
    static var previews: some View {
        SettingsUI()
    }
}

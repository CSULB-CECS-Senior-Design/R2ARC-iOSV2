//
//  MenuScreen.swift
//  R2ARC
//
//  Created by Shane Lobsinger on 4/7/24.
//

import SwiftUI

struct MenuScreen: View {
    var body: some View {

        VStack {
            Image("R2ARC") // Referencing the image by its name in the asset catalog
                .resizable() // Make the image resizable
                .aspectRatio(contentMode: .fit) // Maintain the aspect ratio
                .frame(width: 100, height: 100) // Adjust the size as needed

            Spacer()
            // Camera View Button
            NavigationLink(destination: Settings()) {
                MenuButton(title: "Settings", iconName: "gear")
            }
            // R2Arc Control Button
            NavigationLink(destination: R2ArcControlView(bleManager: BLEManager())) {
                MenuButton(title: "R2Arc Control", iconName: "antenna.radiowaves.left.and.right")
            }
            // Emergency Services Button
            NavigationLink(destination: EmergencyServicesView()) {
                MenuButton(title: "Emergency Services", iconName: "exclamationmark.triangle")
            }
            // User Information Button
            NavigationLink(destination: UserInformationView()) {
                MenuButton(title: "User Information", iconName: "person.crop.circle")
            }

            Spacer()
        }
    }
}

// Menu button view
struct MenuButton: View {
    var title: String
    var iconName: String
    var isActive: Bool = true

    var body: some View {
        if isActive {
            HStack {
                Image(systemName: iconName)
                Text(title)
                    .fontWeight(.semibold)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.yellow)
            .foregroundColor(.black)
            .cornerRadius(10)
            .padding(.horizontal)
        } else {
            HStack {
                Image(systemName: iconName)
                Text(title)
                    .fontWeight(.semibold)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
}

struct Settings: View {
    var body: some View {
            List {
                NavigationLink(destination: VersionInfoView()) {
                    Text("Version Info")
                }
                NavigationLink(destination: AboutUsView()) {
                    Text("About Us")
                }
                NavigationLink(destination: LegalView()) {
                    Text("Legal")
                }
            }
            .navigationTitle("Settings")
    }
}

struct R2ArcControlView: View {
    @ObservedObject var bleManager = BLEManager()
    var body: some View {
        ModeTypeView(bleManager: bleManager)
    }
    
}

struct EmergencyServicesView: View {
    var body: some View {
        Text("Emergency Contacts")
    }
}

struct UserInformationView: View {
    @State private var userName: String = "Darth Vader"
    @State private var userEmail: String = "not_anakinskywalker@gmail.com"
    let profileImage: Image = Image("ProfilePic") // Updated to use a more generic asset name
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            profileImage
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 4))
            
            Text("User Information")
                .font(.title)
                .fontWeight(.bold)
            
            HStack {
                Text("Name: ")
                    .fontWeight(.semibold)
                Text(userName)
            }
            
            HStack {
                Text("Email: ")
                    .fontWeight(.semibold)
                Text(userEmail)
            }
        }
        .padding()
    }
}

struct MenuScreen_Previews: PreviewProvider {
    static var previews: some View {
        MenuScreen()
    }
}

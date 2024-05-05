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
            NavigationLink(destination: EmergencyContactView()) {
                MenuButton(title: "Emergency Contacts", iconName: "exclamationmark.triangle")
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

struct EmergencyContactView: View {
    @State private var relationship: String = UserDefaults.standard.string(forKey: "emergencyRelationship") ?? ""
    @State private var cellPhone: String = UserDefaults.standard.string(forKey: "emergencyCellPhone") ?? ""
    @State private var homePhone: String = UserDefaults.standard.string(forKey: "emergencyHomePhone") ?? ""
    @State private var workPhone: String = UserDefaults.standard.string(forKey: "emergencyWorkPhone") ?? ""
    @State private var address: String = UserDefaults.standard.string(forKey: "emergencyAddress") ?? ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Emergency Contact Information")
                .font(.title)
                .fontWeight(.bold)
            
            HStack {
                Text("Relationship: ")
                    .fontWeight(.semibold)
                TextField("Enter relationship", text: $relationship)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            HStack {
                Text("Cell Phone: ")
                    .fontWeight(.semibold)
                TextField("Enter cell phone number", text: $cellPhone)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.phonePad)
            }

            HStack {
                Text("Home Phone: ")
                    .fontWeight(.semibold)
                TextField("Enter home phone number", text: $homePhone)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.phonePad)
            }

            HStack {
                Text("Work Phone: ")
                    .fontWeight(.semibold)
                TextField("Enter work phone number", text: $workPhone)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.phonePad)
            }

            HStack {
                Text("Address: ")
                    .fontWeight(.semibold)
                TextField("Enter address", text: $address)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            Button(action: saveEmergencyContactData) {
                Text("Save Emergency Contact")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(10)
            }
        }
        .padding()
    }

    private func saveEmergencyContactData() {
        UserDefaults.standard.set(relationship, forKey: "emergencyRelationship")
        UserDefaults.standard.set(cellPhone, forKey: "emergencyCellPhone")
        UserDefaults.standard.set(homePhone, forKey: "emergencyHomePhone")
        UserDefaults.standard.set(workPhone, forKey: "emergencyWorkPhone")
        UserDefaults.standard.set(address, forKey: "emergencyAddress")
        print("Emergency contact data saved successfully")
    }
}


struct UserInformationView: View {
    @State private var userName: String = UserDefaults.standard.string(forKey: "userName") ?? ""
    @State private var userEmail: String = UserDefaults.standard.string(forKey: "userEmail") ?? ""
    @State private var userPhone: String = UserDefaults.standard.string(forKey: "userPhone") ?? ""
    @State private var userAddress: String = UserDefaults.standard.string(forKey: "userAddress") ?? ""

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("User Information")
                .font(.title)
                .fontWeight(.bold)
            
            // Name input field
            HStack {
                Text("Name: ")
                    .fontWeight(.semibold)
                TextField("Enter your name", text: $userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.words)
            }
            
            // Email input field
            HStack {
                Text("Email: ")
                    .fontWeight(.semibold)
                TextField("Enter your email", text: $userEmail)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
            }
            
            // Phone input field
            HStack {
                Text("Phone: ")
                    .fontWeight(.semibold)
                TextField("Enter your phone number", text: $userPhone)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.phonePad)
            }
            
            // Address input field
            HStack {
                Text("Address: ")
                    .fontWeight(.semibold)
                TextField("Enter your home address", text: $userAddress)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }

            // Save button
            Button(action: saveUserData) {
                Text("Save Information")
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.yellow)
                    .cornerRadius(10)
            }
        }
        .padding()
    }

    private func saveUserData() {
        UserDefaults.standard.set(userName, forKey: "userName")
        UserDefaults.standard.set(userEmail, forKey: "userEmail")
        UserDefaults.standard.set(userPhone, forKey: "userPhone")
        UserDefaults.standard.set(userAddress, forKey: "userAddress")
        print("Data saved successfully")
    }
}






struct MenuScreen_Previews: PreviewProvider {
    static var previews: some View {
        MenuScreen()
    }
}

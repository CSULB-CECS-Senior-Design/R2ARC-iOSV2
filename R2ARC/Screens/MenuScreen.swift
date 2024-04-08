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
            NavigationLink(destination: R2ArcControlView()) {
                MenuButton(title: "R2Arc Control With Camera", iconName: "antenna.radiowaves.left.and.right")
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
            .background(Color.blue)
            .foregroundColor(.white)
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

// Placeholder views for navigation destinations
struct Settings: View {
    var body: some View {
        List {
            NavigationLink(destination: BlueTooth(bleManager: BLEManager())) {
                Text("Bluetooth Settings")
            }
        }
        .navigationBarTitle("Settings", displayMode: .large)
    }
}


struct R2ArcControlView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                HStack {
                    Spacer(minLength: geometry.size.width * 0.05) // Adjusting space to the left
                    DirectionalPad(size: geometry.size.width > geometry.size.height ? 50 : 75, hasPhotoButton: geometry.size.width <= geometry.size.height)
                    Spacer() // Central spacer for landscape mode, adjusting layout dynamically
                    if geometry.size.width > geometry.size.height {
                        PhotoButton(size: 75) // Larger photo button for landscape orientation
                    }
                    Spacer(minLength: geometry.size.width * 0.05) // Adjusting space to the right
                }
                Spacer()
            }
        }
    }
}

struct DirectionalPad: View {
    var size: CGFloat
    var hasPhotoButton: Bool = false

    var body: some View {
        VStack {
            MoveButton(direction: .forward, size: size)
            HStack {
                MoveButton(direction: .left, size: size)
                if hasPhotoButton {
                    PhotoButton(size: size)
                }
                MoveButton(direction: .right, size: size)
            }
            MoveButton(direction: .backward, size: size)
        }
    }
}

struct MoveButton: View {
    let direction: ControlDirection
    var size: CGFloat

    var body: some View {
        Button(action: {
            // Action for sending movement command
        }) {
            Image(systemName: direction.systemImageName)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
        }
        .buttonStyle(PlainButtonStyle()) // Ensures the button does not show any default highlight or style beyond what's defined
        .opacity(0.5)
    }
}

struct PhotoButton: View {
    var size: CGFloat

    var body: some View {
        Button(action: {
            // Action for taking a photo
        }) {
            Image(systemName: "camera.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
        }
        .buttonStyle(PlainButtonStyle()) // Ensures the button does not show any default highlight or style beyond what's defined
        .opacity(0.5)
    }
}

enum ControlDirection {
    case forward, backward, left, right

    var systemImageName: String {
        switch self {
        case .forward: return "arrow.up.circle.fill"
        case .backward: return "arrow.down.circle.fill"
        case .left: return "arrow.left.circle.fill"
        case .right: return "arrow.right.circle.fill"
        }
    }
}

struct EmergencyServicesView: View {
    var body: some View {
        Text("Emergency Services View")
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

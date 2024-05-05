//
//  WelcomeScreen.swift
//  R2ARC
//
//  Created by Shane Lobsinger on 4/7/24.
//

import SwiftUI


struct WelcomeScreen: View {
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer()
                    // Use a standard Image initializer with the asset's name
                    Image("R2ARC")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal)
                    Spacer()

                    NavigationLink(destination: MenuScreen()) {
                        PrimaryButton(title: "Main Menu")
                    }
                    .padding(.vertical)
                    
                    HStack {
                        Text("                      Welcome to R2ARC!")
                        Spacer()
                    }
                }
                .padding()
            }
        }
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}

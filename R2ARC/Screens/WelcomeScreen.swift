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
                Color("BgColor").edgesIgnoringSafeArea(.all)
                VStack {
                    Spacer()
                    // Use a standard Image initializer with the asset's name
                    Image("R2ARC")
                        .resizable()
                        .scaledToFit()
                        .padding(.horizontal)
                    Spacer()

                    NavigationLink(destination: MenuScreen()) {
                        PrimaryButton(title: "Get Started")
                    }
                    .padding(.vertical)
                    
                    NavigationLink(destination: SignInScreen()) {
                        Text("Sign In")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color("PrimaryColor"))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(50.0)
                            .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                            .padding(.vertical)
                    }
                    
                    HStack {
                        Text("Welcome to project R2ARC")
                        Spacer()
                        Text("Sign in").foregroundColor(Color("PrimaryColor"))
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

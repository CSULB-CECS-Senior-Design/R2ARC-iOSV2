//
//  SigninScreen.swift
//  R2ARC
//
//  Created by Shane Lobsinger on 4/7/24.
//


import SwiftUI

struct SignInScreen: View {
    @State private var email: String = "" // By default it's empty
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            VStack {
                // Back Button
                HStack {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.black)
                            .padding()
                    }
                    Spacer()
                }
                
                Spacer()
                
                VStack {
                    Text("Sign In")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                    
                    SocialLoginButton(image: Image("apple"), text: Text("Sign in with Apple"))
                    
                    SocialLoginButton(image: Image("google"), text: Text("Sign in with Google").foregroundColor(Color("PrimaryColor")))
                        .padding(.vertical)
                    
                    Text("or get a link emailed to you")
                        .foregroundColor(Color.black.opacity(0.4))
                    
                    TextField("Work email address", text: $email)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                        .padding(.vertical)
                    
                    PrimaryButton(title: "Email me a signup link")
                }
                
                Spacer()
                Divider()
                Spacer()
                Text("Testing phase not ready for commercial use")
                Text("placeholder")
                    .foregroundColor(Color("PrimaryColor"))
                Spacer()
            }
            .padding()
        }
    }
}

struct SignInScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreen()
    }
}

struct SocialLoginButton: View {
    var image: Image
    var text: Text
    
    var body: some View {
        HStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 24)
                .padding(.horizontal)
            Spacer()
            text
                .font(.title2)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(50.0)
        .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
    }
}





//
//  ContentView.swift
//  R2ARC
//
//  Created by Shane Lobsinger on 4/7/24.
//

import SwiftUI

struct ContentView: View {
   
    var body: some View {
        WelcomeScreen()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct PrimaryButton: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.yellow)
            .cornerRadius(50)
    }
}

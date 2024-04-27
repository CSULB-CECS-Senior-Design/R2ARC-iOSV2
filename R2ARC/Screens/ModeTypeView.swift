//
//  ModeTypeView.swift
//  R2ARC
//
//  Created by Shane Lobsinger on 4/9/24.
//

import SwiftUI

// ModeTypeView definition
struct ModeTypeView: View {
    @ObservedObject var bleManager = BLEManager()

    var body: some View {
        VStack {
            BLEStatusView(isConnected: bleManager.isConnected)
            
            Spacer()
            
            VStack(spacing: 20) {
                // Remote Control Mode Link
                NavigationLink(destination: BlueTooth(bleManager: bleManager)) {
                    menuButtonLabel("Remote Control Mode")
                }
                .simultaneousGesture(TapGesture().onEnded {
                    bleManager.sendMessage(message: "R")
                })

                
                // Autonomous Following Mode Button
                Button("Autonomous Following Mode") {
                    bleManager.sendMessage(message: "F")
                }
                .buttonStyle(PrimaryButtonStyle(isConnected: bleManager.isConnected))

            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal)

            Spacer()
        }
        .navigationBarTitle("Mode Selection", displayMode: .inline) // Apply navigation bar title here
    }
    
    @ViewBuilder
    private func menuButtonLabel(_ text: String) -> some View {
        Text(text)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
    }
}

// Additional struct definitions

struct PrimaryButtonStyle: ButtonStyle {
    var isConnected: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding()
            .frame(maxWidth: .infinity)
            .background(isConnected ? Color.green : Color.green.opacity(0.5))
            .foregroundColor(.white)
            .cornerRadius(10)
            .disabled(!isConnected)
    }
}

struct BLEStatusView: View {
    var isConnected: Bool

    var body: some View {
        Text(isConnected ? "Connected to Raspberry Pi" : "Scanning for Raspberry Pi...")
            .foregroundColor(isConnected ? .green : .red)
            .padding()
            .transition(.slide)
            .animation(.easeInOut, value: isConnected)
    }
}

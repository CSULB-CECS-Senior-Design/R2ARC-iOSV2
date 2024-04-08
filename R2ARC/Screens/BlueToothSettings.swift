//
//  BlueToothSettings.swift
//  R2ARC
//
//  Created by Shane Lobsinger on 4/7/24.
//
struct BlueToothSettings: View {
    @ObservedObject var bleManager = BLEManager()

    var body: some View {
        NavigationView {
            VStack {
                BLEStatusView(isConnected: bleManager.isConnected)
                
                Spacer() // Pushes everything below upwards
                
                VStack(spacing: 20) {
                    NavigationLink(destination: RemoteControlView(bleManager: bleManager)) {
                        Text("Remote Control Mode")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        bleManager.sendMessage(message: "R")
                    })

                    Button("Autonomous Following Mode") {
                        bleManager.sendMessage(message: "F")
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(bleManager.isConnected ? Color.green : Color.green.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .disabled(!bleManager.isConnected)
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal) // Adds horizontal padding

                Spacer() // Pushes everything above downwards
            }
            .navigationBarTitle("Main Menu", displayMode: .inline)
        }
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

#Preview {
    ContentView()
}



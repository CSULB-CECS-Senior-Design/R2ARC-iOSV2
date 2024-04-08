//
//  BlueTooth.swift
//  R2ARC
//
//  Created by Shane Lobsinger on 4/7/24.
//

import SwiftUI



struct BlueTooth: View {
    @ObservedObject var bleManager: BLEManager
    @State private var isLandscape: Bool = false
    private let buttonSize: CGFloat = 60

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Remote Control")
                    .font(.headline)
                    .padding(.top)
                    .foregroundColor(bleManager.isConnected ? .primary : .gray) // Color change based on connection

                Spacer()

                if isLandscape {
                    HStack {
                        Spacer()
                        NavigationPad(isActive: bleManager.isConnected, size: buttonSize, onDirectionPressed: { direction in
                            bleManager.sendMessage(message: direction.rawValue)
                        }, onDirectionReleased: {
                            bleManager.sendMessage(message: "Q")
                        })
                    }
                } else {
                    VStack {
                        Spacer()
                        NavigationPad(isActive: bleManager.isConnected, size: buttonSize, onDirectionPressed: { direction in
                            bleManager.sendMessage(message: direction.rawValue)
                        }, onDirectionReleased: {
                            bleManager.sendMessage(message: "Q")
                        })
                    }
                }
            }
            .onAppear {
                isLandscape = UIDevice.current.orientation.isLandscape
            }
            .onDisappear {
                bleManager.sendMessage(message: "Q")
            }
            .onRotate { newOrientation in
                isLandscape = newOrientation.isLandscape
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}

struct NavigationPad: View {
    var isActive: Bool
    var size: CGFloat
    var onDirectionPressed: (ControlDirections) -> Void
    var onDirectionReleased: () -> Void

    var body: some View {
        VStack {
            ControlButton(direction: .forward, isActive: isActive, size: size, onDirectionPressed: onDirectionPressed, onDirectionReleased: onDirectionReleased)
            HStack {
                ControlButton(direction: .left, isActive: isActive, size: size, onDirectionPressed: onDirectionPressed, onDirectionReleased: onDirectionReleased)
                Spacer().frame(width: size)
                ControlButton(direction: .right, isActive: isActive, size: size, onDirectionPressed: onDirectionPressed, onDirectionReleased: onDirectionReleased)
            }
            ControlButton(direction: .backward, isActive: isActive, size: size, onDirectionPressed: onDirectionPressed, onDirectionReleased: onDirectionReleased)
        }
    }
}


struct ControlButton: View {
    let direction: ControlDirections
    var isActive: Bool
    var size: CGFloat
    var onDirectionPressed: (ControlDirections) -> Void
    var onDirectionReleased: () -> Void

    var body: some View {
        Image(systemName: direction.systemImageName)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
            .foregroundColor(isActive ? .blue : .gray)
            .opacity(isActive ? 1 : 0.3)
            .contentShape(Rectangle())
            .gesture(DragGesture(minimumDistance: 0)
                .onChanged({ _ in onDirectionPressed(direction) })
                .onEnded({ _ in onDirectionReleased() })
            )
            .disabled(!isActive)
    }
}

enum ControlDirections: String {
    case forward = "W", left = "A", backward = "S", right = "D"

    var systemImageName: String {
        switch self {
        case .forward: return "arrow.up.circle.fill"
        case .backward: return "arrow.down.circle.fill"
        case .left: return "arrow.left.circle.fill"
        case .right: return "arrow.right.circle.fill"
        }
    }
}

extension View {
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}

struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}

struct BlueTooth_Previews: PreviewProvider {
    static var previews: some View {
        BlueTooth(bleManager: BLEManager())
    }
}

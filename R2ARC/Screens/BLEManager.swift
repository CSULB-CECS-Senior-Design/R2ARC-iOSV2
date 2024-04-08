//
//  BLEManager.swift
//  R2-ARC_BLE_only
//
//  Created by Kevin Martinez Lopez on 4/2/24.
//

import CoreBluetooth
import Foundation

// Custom class to manage Bluetooth Low Energy (BLE) interactions.
class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    @Published var isConnected: Bool = false // Published property to observe connection changes in views.
    
    var centralManager: CBCentralManager! // Core Bluetooth central manager.
    @Published var raspberryPiPeripheral: CBPeripheral? // The peripheral device we're connecting to.
    
    // Service and characteristic UUIDs specific to the Raspberry Pi communication.
    let raspberryPiServiceUUID = CBUUID(string: "12345678-1234-1234-1234-123456789012")
    let simpleCharacteristicUUID = CBUUID(string: "87654321-4321-4321-4321-210987654321")
    
    var reconnectAttempts = 0
    let maxReconnectAttempts = 5
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    // Method called when the central manager's state updates.
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            // If Bluetooth is on, start scanning for peripherals with the Raspberry Pi service UUID.
            centralManager.scanForPeripherals(withServices: [raspberryPiServiceUUID], options: nil)
        } else {
            print("Bluetooth not available.")
        }
    }
    
    // Helper method to initiate scanning for peripherals.
    func startScanning() {
        // Reset reconnect attempts when manually starting a scan
        reconnectAttempts = 0
        attemptReconnect()
    }

    func attemptReconnect() {
        guard centralManager.state == .poweredOn else {
            print("Bluetooth is not powered on.")
            return
        }
        
        if reconnectAttempts < maxReconnectAttempts {
            centralManager.scanForPeripherals(withServices: [raspberryPiServiceUUID], options: nil)
            reconnectAttempts += 1
        } else {
            print("Max reconnect attempts reached. Stopping attempts.")
            // Reset the counter or handle the max attempts being reached as needed
        }
    }
    
    // Called when a peripheral is discovered while scanning.
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        raspberryPiPeripheral = peripheral
        centralManager.stopScan() // Stop scanning as we found the device.
        centralManager.connect(peripheral, options: nil) // Attempt to connect to the discovered peripheral.
    }
    
    // Called when the central manager connects to a peripheral.
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        self.isConnected = true
        self.reconnectAttempts = 0 // Reset the reconnection attempts on a successful connection
        peripheral.delegate = self
        peripheral.discoverServices([raspberryPiServiceUUID]) // Discover services on the connected peripheral.
    }
    
    // Called when the central manager disconnects from a peripheral.
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        self.isConnected = false
        // Optionally handle the error here if needed
        if let error = error {
            print("Disconnected with error: \(error.localizedDescription)")
        }
        let delaySeconds = pow(2.0, Double(reconnectAttempts)) // Exponential backoff
        DispatchQueue.main.asyncAfter(deadline: .now() + delaySeconds) {
            self.attemptReconnect()
        }
    }
    
    // Called when services are discovered on the peripheral.
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics([simpleCharacteristicUUID], for: service) // Discover characteristics for each service.
        }
    }
    
    // Called when characteristics are discovered for a service.
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics where characteristic.uuid == simpleCharacteristicUUID {
            // Ready to send a message or subscribe to notifications.
        }
    }
    
    // Sends a message to the peripheral device.
    func sendMessage(message: String) {
        guard isConnected, let peripheral = raspberryPiPeripheral,
              let service = peripheral.services?.first(where: { $0.uuid == raspberryPiServiceUUID }),
              let characteristic = service.characteristics?.first(where: { $0.uuid == simpleCharacteristicUUID }) else {
            print("Device not ready or not connected")
            return
        }
        
        // Create data from the message string and send it to the characteristic.
        if let data = message.data(using: .utf8) {
            peripheral.writeValue(data, for: characteristic, type: .withResponse)
        }
    }
}


//
//import CoreBluetooth
//import Foundation
//
//class BLEManager: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
//    @Published var isConnected: Bool = false
//    
//    var centralManager: CBCentralManager!
//    @Published var raspberryPiPeripheral: CBPeripheral?
//    
//    let raspberryPiServiceUUID = CBUUID(string: "12345678-1234-1234-1234-123456789012")
//    let simpleCharacteristicUUID = CBUUID(string: "87654321-4321-4321-4321-210987654321")
//    
//    override init() {
//        super.init()
//        centralManager = CBCentralManager(delegate: self, queue: nil)
//    }
//    
//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        if central.state == .poweredOn {
//            centralManager.scanForPeripherals(withServices: [raspberryPiServiceUUID], options: nil)
//        } else {
//            print("Bluetooth not available.")
//        }
//    }
//    
//    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
//        raspberryPiPeripheral = peripheral
//        centralManager.stopScan()
//        centralManager.connect(peripheral, options: nil)
//    }
//    
//    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
//        self.isConnected = true
//        peripheral.delegate = self
//        peripheral.discoverServices([raspberryPiServiceUUID])
//    }
//    
//    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
//        self.isConnected = false
//        // Optionally restart scanning or handle the disconnection as needed
//    }
//    
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
//        guard let services = peripheral.services else { return }
//        for service in services {
//            peripheral.discoverCharacteristics([simpleCharacteristicUUID], for: service)
//        }
//    }
//    
//    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
//        guard let characteristics = service.characteristics else { return }
//        for characteristic in characteristics where characteristic.uuid == simpleCharacteristicUUID {
//            // The device is now ready to send a message or subscribe to notifications if needed
//        }
//    }
//    
//    // Function to send custom messages
//    func sendMessage(message: String) {
//        guard isConnected, let peripheral = raspberryPiPeripheral,
//              let service = peripheral.services?.first(where: { $0.uuid == raspberryPiServiceUUID }),
//              let characteristic = service.characteristics?.first(where: { $0.uuid == simpleCharacteristicUUID }) else {
//            print("Device not ready or not connected")
//            return
//        }
//        
//        if let data = message.data(using: .utf8) {
//            peripheral.writeValue(data, for: characteristic, type: .withResponse)
//        }
//    }
//}

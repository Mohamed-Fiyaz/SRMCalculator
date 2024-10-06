//
//  SRMCalculatorApp.swift
//  SRMCalculator
//
//  Created by Mohamed Fiyaz on 13/09/24.
//

import SwiftUI

@main
struct SRMCalculatorApp: App {
    @State private var isActive: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if isActive {
                // Main content view here
                ContentView()
            } else {
                LaunchScreenView()
                    .onAppear {
                        // Set delay for the transition to the next screen
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.isActive = true
                        }
                    }
            }
        }
    }
}


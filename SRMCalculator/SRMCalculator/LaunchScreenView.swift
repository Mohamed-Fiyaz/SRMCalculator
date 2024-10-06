//
//  LaunchScreenView.swift
//  SRMCalculator
//
//  Created by Mohamed Fiyaz on 14/09/24.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            // Background Color: rgb(7, 102, 171)
            Color(red: 7/255, green: 102/255, blue: 171/255)
                .ignoresSafeArea()

            VStack {
                Spacer()

                // Logo Section
                VStack(spacing: 10) {
                    Image("Logo-light")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 100)
                    
                }

                Spacer()

                // Footer Section
                Text("Made By Mohamed Fiyaz")
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}

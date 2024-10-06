//
//  ContentView.swift
//  SRMCalculator
//
//  Created by Mohamed Fiyaz on 13/09/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .center) {
                        Spacer(minLength: geometry.size.height * 0.1) // Add dynamic spacing at the top
                        
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                            .padding(.top, 50)

                        NavigationLink(destination: SGPAView()) {
                            Text("SGPA Calculator")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding(.bottom, 10)

                        NavigationLink(destination: CGPAView()) {
                            Text("CGPA Calculator")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding(.bottom, 10)

                        Spacer(minLength: geometry.size.height * 0.1) // Add dynamic spacing at the bottom

                        Text("Made By Mohamed Fiyaz")
                            .font(.footnote)
                            .padding(.bottom, 20)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding(.horizontal)
                    .frame(minHeight: geometry.size.height) // Ensure minimum height fills the screen
                }
                .frame(width: geometry.size.width, height: geometry.size.height) // Adapt to screen size
            }
            .background(Color.white) // Ensure background color is consistent
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Fix for iPads
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

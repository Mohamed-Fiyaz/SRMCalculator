//
//  CGPAView.swift
//  SRMCalculator
//
//  Created by Mohamed Fiyaz on 13/09/24.
//

import SwiftUI

struct CGPAView: View {
    @State private var semesters: [Semester] = Array(repeating: Semester(credit: "", sgpa: ""), count: 8)
    @State private var cgpaResult: String = ""

    var body: some View {
        VStack(spacing: 0) {
            // Top fixed navbar
            HStack {
                Image("logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 100)
            }
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.2))
            
            // Scrollable content for CGPA view
                VStack(spacing: 20) {
                    HStack {
                        Text("Semester").font(.headline).frame(maxWidth: .infinity)
                        Text("Credits").font(.headline).frame(maxWidth: .infinity)
                        Text("SGPA").font(.headline).frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    .padding(.trailing, 35)
                    ScrollView {
                        VStack(spacing: 20){
                            // Loop through each semester to show its input fields
                            ForEach(semesters.indices, id: \.self) { index in
                                HStack(spacing: 20) {
                                    Text("\(index + 1)")
                                        .frame(maxWidth: .infinity)
                                    
                                    TextField("Credits", text: $semesters[index].credit)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.decimalPad)
                                        .frame(maxWidth: .infinity)
                                    
                                    TextField("SGPA", text: $semesters[index].sgpa)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.decimalPad)
                                        .frame(maxWidth: .infinity)
                                    
                                    Button(action: {
                                        semesters.remove(at: index)
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.red)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                            // Add more button
                            Button(action: {
                                semesters.append(Semester(credit: "", sgpa: ""))
                            }) {
                                Text("Add More")
                                    .frame(width: 100, height: 40)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding(.bottom, 10)
                            }
                        }
                    }
                    
  
                }
                .background(Color.white) // Set middle section to white
                .navigationBarTitle("CGPA", displayMode: .inline)
                .onTapGesture {
                    hideKeyboard()
                }
                
                // Bottom navbar-like section with buttons
                VStack {
                    // Bottom fixed navbar
                    VStack(spacing: 20) {
                        // Display CGPA result
                        HStack {
                            Text("Your CGPA is: ")
                            Text("\(cgpaResult)")
                                .fontWeight(.bold)
                        }
                        .padding(.top, 20)
                        HStack {
                            Button(action: calculateCGPA) {
                                Text("Calculate CGPA")
                                    .frame(width: 150, height: 50)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }

                            Button(action: resetValues) {
                                Text("Reset")
                                    .frame(width: 150, height: 50)
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.bottom, 10)
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0))) // Bottom section color #D9D9D9
                }
            }
        }

    // Helper functions
    private func calculateCGPA() {
        var totalGradePoints = 0.0
        var totalCredits = 0.0

        for semester in semesters {
            if let credit = Double(semester.credit), let sgpa = Double(semester.sgpa) {
                totalGradePoints += credit * sgpa
                totalCredits += credit
            }
        }

        let cgpa = totalCredits == 0 ? 0 : totalGradePoints / totalCredits
        cgpaResult = String(format: "%.2f", cgpa)
    }

    private func resetValues() {
        semesters = Array(repeating: Semester(credit: "", sgpa: ""), count: 8)
        cgpaResult = ""
    }
}

struct CGPAView_Previews: PreviewProvider {
    static var previews: some View {
        CGPAView()
    }
}

struct Semester {
    var credit: String
    var sgpa: String
}

// Dismiss keyboard helper
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

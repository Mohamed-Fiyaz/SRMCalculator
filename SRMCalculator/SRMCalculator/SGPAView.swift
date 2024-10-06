//
//  SGPAView.swift
//  SRMCalculator
//
//  Created by Mohamed Fiyaz on 13/09/24.
//

import SwiftUI

struct SGPAView: View {
    @State private var subjects: [Subject] = Array(repeating: Subject(credit: 0, grade: "O"), count: 7)
    @State private var sgpaResult: String = ""
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""

    let grades = ["O", "A+", "A", "B+", "B", "C", "W", "*", "Ab", "I", "F"]
    let gradePoints: [String: Double] = ["O": 10, "A+": 9, "A": 8, "B+": 7, "B": 6, "C": 5, "W": 0, "*": 0, "Ab": 0, "I": 0, "F": 0]

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

            VStack(spacing: 10) {
                HStack(spacing: -30) {
                    Text("Subject").font(.headline).frame(maxWidth: .infinity)
                    Text("Credits").font(.headline).frame(maxWidth: .infinity)
                    Text("Grade").font(.headline).frame(maxWidth: .infinity)
                }
                .padding(.top, 20)

                // Scrollable content in the middle
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(0..<subjects.count, id: \.self) { index in
                            HStack(spacing: -30) {
                                Text("\(index + 1)")
                                    .frame(maxWidth: .infinity)

                                // Smaller TextField for Credit input
                                TextField("Credits", text: Binding(
                                    get: {
                                        String(subjects[index].credit)
                                    },
                                    set: { newValue in
                                        if newValue.isEmpty {
                                            subjects[index].credit = 0
                                            showError = false
                                        } else if let intValue = Int(newValue), intValue >= 0 {
                                            subjects[index].credit = intValue
                                            showError = false // Clear error when valid input
                                        } else {
                                            showError = true
                                            errorMessage = "Please enter a valid whole number for Credit."
                                        }
                                    }
                                ))
                                .keyboardType(.numberPad)
                                .frame(maxWidth: .infinity)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .foregroundColor(showError ? .red : .primary)
                                .padding(.horizontal, 35)

                                Picker("Grade", selection: $subjects[index].grade) {
                                    ForEach(grades, id: \.self) { grade in
                                        Text(grade).tag(grade)
                                    }
                                }
                                .pickerStyle(MenuPickerStyle())
                                .frame(maxWidth: .infinity)

                                Button(action: {
                                    subjects.remove(at: index)
                                    if subjects.isEmpty {
                                        showError = false // Hide error if no subjects are left
                                    }
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red)
                                }
                                .padding(.trailing)
                            }
                            .frame(maxWidth: .infinity)
                        }

                        // Show error message if any
                        if showError {
                            Text(errorMessage)
                                .foregroundColor(.red)
                                .font(.footnote)
                                .padding(.top, 5)
                        }

                        Button(action: {
                            subjects.append(Subject(credit: 0, grade: "O"))
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
            .navigationBarTitle("SGPA", displayMode: .inline)
            .onTapGesture {
                hideKeyboard()
            }

            // Bottom navbar-like section with buttons
            VStack {
                HStack {
                    Text("Your SGPA is: ")
                    Text("\(sgpaResult)")
                        .fontWeight(.bold)
                }
                .padding(.top, 20)
                HStack {
                    Button(action: calculateSGPA) {
                        Text("Calculate SGPA")
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
                .padding(.top, 10)
                .padding(.bottom, 10)

            }
            .frame(maxWidth: .infinity)
            .background(Color(UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1.0))) // Bottom section color #D9D9D9
        }
    }

    private func calculateSGPA() {
        var totalGradePoints = 0.0
        var totalCredits = 0

        for subject in subjects {
            let credit = subject.credit
            let grade = subject.grade
            totalGradePoints += Double(credit) * (gradePoints[grade] ?? 0)
            totalCredits += credit
        }

        let sgpa = totalCredits == 0 ? 0 : totalGradePoints / Double(totalCredits)
        sgpaResult = String(format: "%.2f", sgpa)
    }

    private func resetValues() {
        subjects = Array(repeating: Subject(credit: 0, grade: "O"), count: 7)
        sgpaResult = ""
        showError = false
        errorMessage = ""
    }
}

struct SGPAView_Previews: PreviewProvider {
    static var previews: some View {
        SGPAView()
    }
}

struct Subject {
    var credit: Int
    var grade: String
}


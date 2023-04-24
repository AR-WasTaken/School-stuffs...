//
//  ContentView.swift
//  converter docs and unitTests
//
//  Created by Max Christopher Romslo Schulstock on 20/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var celsius: String = ""
    @State private var fahrenheit: String = ""
    @State private var kelvin: String = ""
    
    @State private var lastEdited: String? = nil
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    private func convertAndUpdate() {
        if lastEdited == "celsius" {
            if let value = Double(celsius) {
                fahrenheit = String(format: "%.2f", value * 9 / 5 + 32)
                kelvin = String(format: "%.2f", value + 273.15)
            } else {
                fahrenheit = ""
                kelvin = ""
            }
        } else if lastEdited == "fahrenheit" {
            if let value = Double(fahrenheit) {
                celsius = String(format: "%.2f", (value - 32) * 5 / 9)
                kelvin = String(format: "%.2f", (value - 32) * 5 / 9 + 273.15)
            } else {
                celsius = ""
                kelvin = ""
            }
        } else if lastEdited == "kelvin" {
            if let value = Double(kelvin) {
                celsius = String(format: "%.2f", value - 273.15)
                fahrenheit = String(format: "%.2f", (value - 273.15) * 9 / 5 + 32)
            } else {
                celsius = ""
                fahrenheit = ""
            }
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Celsius")) {
                    TextField("Celsius", text: $celsius, onEditingChanged: { _ in
                        self.lastEdited = "celsius"
                    })
                        .keyboardType(.decimalPad)
                        .onChange(of: celsius) { _ in
                            if lastEdited == "celsius" {
                                convertAndUpdate()
                            }
                        }
                }
                
                Section(header: Text("Fahrenheit")) {
                    TextField("Fahrenheit", text: $fahrenheit, onEditingChanged: { _ in
                        self.lastEdited = "fahrenheit"
                    })
                        .keyboardType(.decimalPad)
                        .onChange(of: fahrenheit) { _ in
                            if lastEdited == "fahrenheit" {
                                convertAndUpdate()
                            }
                        }
                }
                
                Section(header: Text("Kelvin")) {
                    TextField("Kelvin", text: $kelvin, onEditingChanged: { _ in
                        self.lastEdited = "kelvin"
                    })
                        .keyboardType(.decimalPad)
                        .onChange(of: kelvin) { _ in
                            if lastEdited == "kelvin" {
                                convertAndUpdate()
                            }
                        }
                }
                Section {}
                Section {
                    Button("Reset") {
                        celsius = ""
                        fahrenheit = ""
                        kelvin = ""
                    }
                    Toggle("Dark Mode", isOn: $isDarkMode)
                        .padding()
                }
                
            }
            .navigationBarTitle("Temperature Converter")
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

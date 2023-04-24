//
//  ContentView.swift
//  Valutta-kalkulator
//
//  Created by Max Christopher Romslo Schulstock on 18/02/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var totalBeløp: Double = 0
    @State private var tipsProsent:Double = 0
    @State private var antallPersoner:Int = 4
    @FocusState private var velgTotalbeløp: Bool
    
    var tipsValg: [Double] = [0.1, 0.15, 0.2, 0.25, 0]
    
    var beløpPerPerson: Double {
        totalBeløp*(1+tipsProsent)/Double(antallPersoner)
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Total beløp", value: $totalBeløp, format: .currency(code: "NOK"))
                        .focused($velgTotalbeløp)
                } header: {
                    Text("Skriv inn totalbeløp")
                }
                Section {
                    Picker("Antall Personer", selection: $antallPersoner){
                        ForEach(1..<11){ tall in
                            Text("\(tall)").tag(tall)
                        }
                    }

                    .pickerStyle(.wheel)
                } header: {
                    Text("Velg antall personer")
                }
                Section {
                    Picker("Tips", selection: $tipsProsent) {
                        ForEach(tipsValg, id: \.self){ tips in
                            Text(tips, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Velg tips")
                }
                Section {
                    Text(beløpPerPerson, format: .currency(code: "NOK"))
                } header: {
                    Text("Totalbeløp")
                }

            }
            .navigationTitle("Regnigsdeler 2IMT")
        }
        
        Button{
            velgTotalbeløp.toggle()
        } label: {
            Spacer()
            Color.red.frame(width: 50, height: 50, alignment: .trailing).padding(.trailing)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


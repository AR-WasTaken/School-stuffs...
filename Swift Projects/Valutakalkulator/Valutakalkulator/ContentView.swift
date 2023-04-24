//
//  ContentView.swift
//  Valutakalkulator
//
//  Created by Max Christopher Romslo Schulstock on 18/02/2023.
//

import SwiftUI

import Foundation

struct Svar: Codable {
    var disclaimer: String
    var license: String
    var timestamp: Int
    var base: String
    var rates: Rates
    
}

struct Rates: Codable {
    var NOK: Double
}


func lastInttValuta(urlString: String) async -> Svar? {
    let url = URL(string: urlString)!
    let urlrequest = URLRequest(url: url)
    
    do {
        let (data, _) = try await URLSession.shared.data(for: urlrequest)
        do {
            let svar = try JSONDecoder().decode(Svar.self, from: data)
            return svar
        }
        catch {
            print("Klarte ikke dekode")
            return nil
        }
    }
    catch {
        print("Klarte ikke hente data fra nett. ")
        return nil
    }
}



struct ContentView: View {
    @State private var input:Double = 1
    
    @State var kurs: Double = 10.18
    var output: Double {
        input * kurs
    }
    var body: some View {
        VStack {
            TextField("Input", value: $input, format: .currency(code: "USD"))

            
            Text(output, format: .currency(code: "NOK"))
        }
        .padding()
        .task {
            kurs = await lastInttValuta(urlString: "https://openexchangerates.org/api/latest.json?app_id=062ea16b4bed4ee9946a29df8ec67aaa")?.rates.NOK ?? 10.18
            print(kurs)
        }
    }
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

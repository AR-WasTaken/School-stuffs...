//
//  ContentView.swift
//  03.02 API med Knapp
//
//  Created by M on 02/03/2023.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @State private var userId: Double? = 0
    @State private var id: Double? = 0
    @State private var title: String = ""
    @State private var text: String = ""

    var body: some View {
        VStack {
            Text("User ID: \(userId ?? 0)")
            Text("ID: \(id ?? 0)")
            Text("Title: \(title)")
            Text("Body: \(text)")
            
            Button("Fetch Data") {
                //Velg API URL for å sende til func
                fetchData(urlString: "https://jsonplaceholder.typicode.com/posts/2")
            }
            .onAppear {
                fetchData(urlString: "https://jsonplaceholder.typicode.com/posts/1")
            }
        }
    }

    // Start funksjon for å hente data fra API
    func fetchData(urlString: String) {
            Task {
                do {
                    // Hent data fra URL
                    let (data, _) = try await URLSession.shared.data(from: URL(string: urlString)!)
                    let decoder = JSONDecoder()
                    // Dekode JSON-dataen til en instans av typen 'Svar'
                    let svar = try decoder.decode(Svar.self, from: data)
                    
                    // Oppdater verdier i viewet på hovedtråden (UI-tråden)
                    DispatchQueue.main.async {
                        self.userId = Double(svar.userId)
                        self.id = Double(svar.id)
                        self.title = svar.title
                        self.text = svar.body
                    }
                    
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }

// Modell for å vise JSON-dataen
struct Svar: Codable {
    let userId: Double
    let id: Double
    let title: String
    let body: String
}






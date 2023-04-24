//
//  ContentView.swift
//  03.02.2023 - Hent fra API og oppdater med knapp
//
//  Created by Max Christopher Romslo Schulstock on 02/03/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

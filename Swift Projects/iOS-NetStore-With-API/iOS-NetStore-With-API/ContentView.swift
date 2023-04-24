//
//  ContentView.swift
//  iOS-NetStore-With-API
//
//  Created by M on 20/03/2023.
//

import SwiftUI
import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rating

    struct Rating: Codable {
        let rate: Double
        let count: Int
    }
}

struct Cart: Codable, Identifiable {
    let id: Int
    let userId: Int
    let date: Date
    let products: [Product]
    
    struct CartProducts: Codable {
        let carts: [Cart]
    }
}


//må bruke VAR hvis ikke er ikke koden "mutable"... og det blir en error...
struct Users: Codable, Identifiable {
    var id: Int = 1
    var username: String = "Johnd"
    var password: String = "m38rmF$"
    
    struct Name: Codable {
        var fName: String = "John"
        var lName: String = "Doe"
    }
}


class DataFetcher: ObservableObject {
    @Published var products: [Product] = []
    @Published var cart: [Cart] = []
    @Published var users: [Users] = []

    func fetchProducts() {
        let urlString = "https://fakestoreapi.com/products"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let products = try decoder.decode([Product].self, from: data)
                    DispatchQueue.main.async {
                        self.products = products
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
    
    func fetchCart() {
        let urlString = "https://fakestoreapi.com/users"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let cart = try decoder.decode([Cart].self, from: data)
                    DispatchQueue.main.async {
                        self.cart = cart
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
    
    func fetchUsers() {
        let urlString = "https://fakestoreapi.com/users"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let users = try decoder.decode([Users].self, from: data)
                    DispatchQueue.main.async {
                        self.users = users
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}


struct ContentView: View {
    @State private var selectedTab = 0
    @State private var isLoggedIn = false

    var body: some View {
        TabView(selection: $selectedTab) {
            ProductView()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(0)
            CartView()
                .tabItem {
                    Image(systemName: "cart")
                    Text("Cart")
                }
                .tag(1)
            ProfileView(isLoggedIn: $isLoggedIn)
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
                .tag(2)
        }
    }
}

struct ProductView: View {
    @StateObject var dataFetcher = DataFetcher()

    var body: some View {
        NavigationView {
            List(dataFetcher.products) { product in
                NavigationLink(destination: ProductDetailView(product: product)) {
                    ProductRowView(product: product)
                }
            }
            .onAppear {
                dataFetcher.fetchProducts()
            }
            .navigationTitle("Fakeazon")
        }
    }
}

struct CartView: View {
    @StateObject var dataFetcher = DataFetcher()
    
    var body: some View {
        Text("Hello - Cart")
    }
}

/*
 
 */

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @State var username = ""
    @State var password = ""
    @State var users = [Users]()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Username")
                            .font(.headline)
                        TextField("Enter your username", text: $username)
                            .autocapitalization(.none)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Password")
                            .font(.headline)
                        SecureField("Enter your password", text: $password)
                            .autocapitalization(.none)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    }
                    Button("Login") {
                        let matchingUser = users.first { $0.username == username && $0.password == password }
                        if let _ = matchingUser {
                            isLoggedIn = true
                        } else {
                            // Show error message
                        }
                    }
                    .padding(.vertical, 13)
                    .padding(.horizontal, 16)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            .padding(.horizontal, 24)
        }
    }
}



struct ProfileView: View {
    @StateObject var dataFetcher = DataFetcher()
    @Binding var isLoggedIn: Bool

    var body: some View {
        if isLoggedIn {
            Text("Welcome back!")
        } else {
            LoginView(isLoggedIn: $isLoggedIn, users: dataFetcher.users)
        }
    }
}




struct ProductRowView: View {
    let product: Product

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.image)) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80.0)
                            } placeholder: {
                                ProgressView()
                            }
            
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.headline)
                Text("$\(product.price, specifier: "%.2f")")
                    .foregroundColor(.gray)
            }
        }
    }
}



struct ProductDetailView: View {
    let product: Product
    
    var body: some View {

        NavigationView {
            List {
                VStack(alignment: .center, spacing: 16) {
                    AsyncImage(url: URL(string: product.image)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 304.0)
                    } placeholder: {
                        ProgressView()
                    }
                    Text(product.title)
                        .font(.largeTitle)
                    
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.title)
                        .foregroundColor(.gray)
                    
                    Text("Description")
                        .font(.headline)
                    
                    Text(product.description)
                        .font(.body)
                    
                    Text("Category")
                        .font(.headline)
                    
                    Text(product.category)
                        .font(.body)
                    
                    Text("Rating")
                        .font(.headline)
                    
                    HStack {
                        Text("\(product.rating.rate, specifier: "%.1f")")
                            .font(.body)
                        Text("(\(product.rating.count) reviews)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                }
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

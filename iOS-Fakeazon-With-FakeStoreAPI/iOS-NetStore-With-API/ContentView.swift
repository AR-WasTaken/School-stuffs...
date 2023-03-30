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
    var id: Int
    var username: String
    var password: String
    var email: String
    var name: Name?
    
    struct Name: Codable {
        var firstname: String
        var lastname: String
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
        let urlString = "https://fakestoreapi.com/carts"
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
        VStack {
            /*NavigationView {
                NavigationLink(destination: ProfileView(isLoggedIn: $isLoggedIn, user: nil)) {
                    Text("ProfileView")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
            }*/
            
            TabView(selection: $selectedTab) {
                ProductView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(0)
                CartView(/*matchedUser: $matchedUser*/)
                    .tabItem {
                        Image(systemName: "cart")
                        Text("Cart")
                    }
                    .tag(1)
                LoginView(isLoggedIn: $isLoggedIn)
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
                    .tag(2)
            }
            .background(Color.white)
            .zIndex(3)
        }
    }
}

struct ProductView: View {
    @StateObject var dataFetcher = DataFetcher()
    
    let categories = ["All", "men's clothing", "women's clothing", "jewelery", "electronics"]
    
    @State private var selectedCategory = "All"

    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                            }) {
                                Text(category.capitalized)
                                    .padding(-2)
                                    .foregroundColor(Color(red: 0.10, green: 0.10, blue: 0.10))
                            }
                            .buttonStyle(BorderedProminentOrBordered(isProminent: selectedCategory == category))
                        }
                    }
                    .padding(.horizontal)
                }
                
                List(filteredProducts()) { product in
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
    
    func filteredProducts() -> [Product] {
        guard selectedCategory != "All" else {
            return dataFetcher.products
        }
        
        return dataFetcher.products.filter { $0.category.lowercased() == selectedCategory.lowercased() }
    }
}

struct BorderedProminentOrBordered: ButtonStyle {
    var isProminent: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(isProminent ? Color.blue : Color(red: 0.97, green: 0.96, blue: 0.99))
            .foregroundColor(isProminent ? Color(red: 0.97, green: 0.96, blue: 0.99) : Color.blue)
            .overlay (
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isProminent ? Color.blue : Color(red: 0.97, green: 0.96, blue: 0.99), lineWidth: 2)
                )
            .cornerRadius(10)
    }
}



struct ProductRowView: View {
    let product: Product

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: product.image)) { image in image
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
        .padding(.vertical, 7)
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
        .padding(.top, -225)
    }
}





struct CartView: View {
    @StateObject var dataFetcher = DataFetcher()
    
//    @Binding var matchedUser: Bool
    
    var body: some View {
        NavigationView {
//            if matchedUser {
//                List(dataFetcher.products) { product in
//                    NavigationLink(destination: ProductDetailView(product: product)) {
//                        ProductRowView(product: product)
//                    }
//                }
//                .onAppear {
//                    dataFetcher.fetchProducts()
//                }
//                .navigationTitle("Cart")
//            }
            Text("Placeholder")
        }
    }
}









struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @StateObject var dataFetcher = DataFetcher()
    @State var username = ""
    @State var password = ""
    @State var email = ""
    @State var users = [Users]()
    @State var showAlert = false
    
    @State var matchedUser: Users?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Email or Username")
                        .font(.headline)
                    TextField("Enter your email or username", text: $username)
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
                Text("m38rmF$")
                
                Text("Username: \(dataFetcher.users.first?.username ?? ""), Email: \(dataFetcher.users.first?.email ?? ""), Password: \(dataFetcher.users.first?.password ?? "")")
                
                Text("Username: \(dataFetcher.users.count > 1 ? dataFetcher.users[1].username : ""), Email: \(dataFetcher.users.count > 1 ? dataFetcher.users[1].email : ""), Password: \(dataFetcher.users.count > 1 ? dataFetcher.users[1].password : "")")

                Button(action: {
                    let matchingUsers = dataFetcher.users.filter { $0.username == username || $0.email == username }
                    
                    if let matchedUser = matchingUsers.first, matchedUser.password == password {
                        isLoggedIn = true
                        self.matchedUser = matchedUser
                        username = ""
                    } else {
                        let matchingEmail = dataFetcher.users.filter { $0.email == email }
                        
                        if let matchedEmailUser = matchingEmail.first, matchedEmailUser.password == password {
                            isLoggedIn = true
                            self.matchedUser = matchedEmailUser
                            password = ""
                        } else {
                            self.showAlert = true
                        }
                    }
                }) {
                    Text(isLoggedIn ? "Logout" : "Login")
                        .padding(.vertical, 13)
                        .padding(.horizontal, 16)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("Incorrect Username/Email or Password"), dismissButton: .default(Text("OK")))
                }
                if isLoggedIn {
                    NavigationLink(destination: ProfileView(isLoggedIn: $isLoggedIn, matchedUser: $matchedUser)) {
                        Text("Go to Profile")
                    }
                }

                
            }
            .padding(.horizontal, 24)
            .onAppear {
                dataFetcher.fetchUsers()
            }
        }
    }
}




//profile view
struct ProfileView: View {
    @StateObject var dataFetcher = DataFetcher()
    @Binding var isLoggedIn: Bool
    @Binding var matchedUser: Users?
    @State var showAlert = false
    
    var user: Users?
    
    var body: some View {
        NavigationView {
            VStack {
                
                HStack {
                    Text(String(matchedUser?.id ?? 0))
                    Button(action: {
                        if isLoggedIn {
                            self.isLoggedIn = false
                        }
                    }) {
                        if isLoggedIn {
                            Text("Logout")
                        } else {
                            Text("not logged in")
                        }
                    }
                    .padding(.vertical, 13)
                    .padding(.horizontal, 16)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.trailing, -30)
                    
                    if !isLoggedIn {
                        NavigationLink(destination: {
                            LoginView(isLoggedIn: $isLoggedIn)
                        }) {
                            EmptyView()
                        }
                    }
                }
                .padding(.leading, 227)
                
                Spacer()
                
                if isLoggedIn {
                    if let matchedUser = matchedUser {
                        displayUserInfo(for: matchedUser)
                    }
                } else if let user = user {
                    displayUserInfo(for: user)
                } else {
                    Text("erronus you aren't logged inn somehow...")
                    //LoginView(isLoggedIn: $isLoggedIn, users: dataFetcher.users)
                }
                
                Spacer()
            }
        }
    }
    
    private func displayUserInfo(for user: Users) -> some View {
        List {
            VStack(alignment: .center, spacing: 16) {
                if let name = user.name {
                    Text("\(name.firstname) \(name.lastname)")
                        .font(.largeTitle)
                }
                Text("Email")
                    .font(.headline)
                
                Text(user.email)
                    .font(.body)
                    .foregroundColor(.gray)
                
                Text("Location")
                    .font(.headline)
                Spacer()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

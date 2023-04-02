//
//  ContentView.swift
//  iOS-NetStore-With-API
//
//  Created by M on 20/03/2023.
//

import SwiftUI

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


//må bruke VAR hvis ikke er ikke koden "mutable"... og det blir en error...
struct Users: Codable, Identifiable {
    var id: Int
    var username: String
    var password: String
    var email: String
    var phone: String
    
    var name: Name?
    var address: Address?

    struct Name: Codable {
        var firstname: String
        var lastname: String
    }

    struct Address: Codable {
        var city: String
        var street: String
        var number: Int
        var zipcode: String
    }
}

//

struct Cart: Codable {
    let id: Int
    let userId: Int
    let date: String
    let products: [Product]
    let __v: Int
    
    struct Product: Codable {
        let productId: Int
        let quantity: Int
    }
}

struct ProductDetails: Codable {
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



struct dataFetcherCart {

    static func fetchData(userId: Int, completion: @escaping (Cart?) -> Void) {
        let urlString = "https://fakestoreapi.com/carts/\(userId)"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let fetchedData = try decoder.decode(Cart.self, from: data)
                    print("Fetched cart data: \(fetchedData)")
                    completion(fetchedData)
                } catch {
                    print("Error decoding data: \(error)")
                    completion(nil)
                }
            } else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }.resume()
    }


    static func fetchProductData(productId: Int, completion: @escaping (ProductDetails?) -> Void) {
        let urlString = "https://fakestoreapi.com/products/\(productId)"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let fetchedData = try decoder.decode(ProductDetails.self, from: data)
                    completion(fetchedData)
                } catch {
                    print("Error decoding data: \(error)")
                    completion(nil)
                }
            } else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }.resume()
    }
}

class DataFetcher: ObservableObject {
    @Published var products: [Product] = []
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
                        print("Fetched Users: \(users)")
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
    @State private var matchedUser: Users?
    
    @StateObject var dataFetcher = DataFetcher()
    
    let userId: Int?
    
    var body: some View {
        VStack {
            TabView(selection: $selectedTab) {
                ProductView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(0)
                CartView(isLoggedIn: $isLoggedIn, matchedUser: $matchedUser)
                    .tabItem {
                        Image(systemName: "cart")
                        Text("Cart")
                    }
                    .tag(1)
                LoginView(isLoggedIn: $isLoggedIn, dataFetcher: dataFetcher)
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
                    .tag(2)
            }
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
        .background(Color.gray)
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
    @Binding var isLoggedIn: Bool
    @Binding var matchedUser: Users?
    @State private var cart: Cart?
    @State private var productDetailsList: [ProductDetails] = []

    var body: some View {
        if isLoggedIn == false {
            Text("Peasle logg in")
        } else {
            VStack {
                if let cart = cart {
                    Text("Cart ID: \(cart.id)")
                    Text("User ID: \(cart.userId)")
                    Text("Date: \(cart.date)")
                    
                    ForEach(productDetailsList, id: \.id) { product in
                        VStack(alignment: .leading) {
                            Text("Product ID: \(product.id)")
                            Text("Title: \(product.title)")
                            Text("Price: \(product.price)")
                            Text("Description: \(product.description)")
                            Text("Category: \(product.category)")
                            Text("Image URL: \(product.image)")
                            Text("Rating: \(product.rating.rate), Count: \(product.rating.count)")
                            Text("Quantity: \(quantityForProduct(withId: product.id))")
                            Divider()
                        }
                    }
                } else {
                    Text("Loading data...")
                }
            }
            .onAppear {
                if let userId = matchedUser?.id {
                    print("Fetching cart data for user ID: \(userId)")
                    dataFetcherCart.fetchData(userId: userId) { fetchedData in
                        DispatchQueue.main.async {
                            self.cart = fetchedData
                            
                            if let products = fetchedData?.products {
                                for product in products {
                                    dataFetcherCart.fetchProductData(productId: product.productId) { fetchedProduct in
                                        DispatchQueue.main.async {
                                            if let fetchedProduct = fetchedProduct {
                                                self.productDetailsList.append(fetchedProduct)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    private func quantityForProduct(withId id: Int) -> Int {
        return cart?.products.first(where: { $0.productId == id })?.quantity ?? 0
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
                HStack {
                    Button(action: {
                        username = "johnd"
                        password = "m38rmF$"
                    }) {
                        Text("John")
                    }
                    Button(action: {
                        username = "mor_2314"
                        password = "83r5^_"
                    }) {
                        Text("Morrison")
                    }
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text("Email or Username")
                        .font(.headline)
                    TextField("Enter your email or username", text: $username)
                        .autocapitalization(.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
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
                        password = ""
                    } else {
                        self.showAlert = true
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
                Text("johnd, and m38rmF$")
            }
            .padding(.horizontal, 24)
            .onAppear {
                print("LoginView Appeared")
                dataFetcher.fetchUsers()
                print(dataFetcher)
                print(dataFetcher.fetchUsers)
            }
        }
    }
}

struct ProfileView: View {
    @Binding var isLoggedIn: Bool
    @Binding var matchedUser: Users?
    @State var showAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoggedIn {
                    if let matchedUser = matchedUser {
                        displayUserInfo(for: matchedUser)
                    }
                } else {
                    Text("You are not logged in")
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
                        .autocapitalization(.none)
               }
                Text("Email")
                    .font(.headline)
                
                Text(user.email)
                    .font(.body)
                    .foregroundColor(.gray)
                
                Text("Location")
                    .font(.headline)
                
                Text(user.address?.city ?? "")
                    .font(.body)
                    .foregroundColor(.gray)
                
                Text("Street / Zipcode")
                    .font(.headline)
                
                HStack {
                    Text(user.address?.street ?? "")
                        .font(.body)
                        .foregroundColor(.gray)

                    Text("\(user.address?.number ?? 0)")
                        .font(.body)
                        .foregroundColor(.gray)
                    
                    Text(user.address?.zipcode ?? "")
                        .font(.body)
                        .foregroundColor(.gray)
                }
                
                Text("Phone")
                    .font(.headline)
                
                Text(user.phone)
                    .font(.body)
                    .foregroundColor(.gray)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(userId: 1)
    }
}


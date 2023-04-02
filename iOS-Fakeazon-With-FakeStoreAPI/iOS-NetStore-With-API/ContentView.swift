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
                CartView(userId: 1, isLoggedIn: $isLoggedIn/*, matchedUser: $matchedUser*/)
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
    let userId: Int?
    @Binding var isLoggedIn: Bool
    @State private var cart: Cart?
    @State private var productDetailsList: [ProductDetails] = []

    var body: some View {
        VStack {
            if isLoggedIn == false {
                Text("Please logg in :)")
            } else {
                VStack {
                    if let cart = cart {
                        ForEach(productDetailsList, id: \.id) { productDetails in
                            VStack(alignment: .leading) {
                                Text("Product ID: \(productDetails.id)")
                                Text("Title: \(productDetails.title)")
                                Text("Price: \(productDetails.price)")
                                Text("Description: \(productDetails.description)")
                                Text("Category: \(productDetails.category)")
                                Text("Image URL: \(productDetails.image)")
                                Text("Rating: \(productDetails.rating.rate), Count: \(productDetails.rating.count)")
                                Text("Quantity: \(quantityForProduct(withId: productDetails.id))")
                            }
                            .padding()
                            Divider()
                        }
                    } else {
                        Text("Loading data...")
                    }
                }
            }
        }

        .onAppear {
            if let userId = self.userId {
                dataFetcherCart.fetchData(userId: userId) { fetchedData in
                    DispatchQueue.main.async {
                        self.cart = fetchedData

                        if let products = fetchedData?.products {
                            for product in products {
                                dataFetcherCart.fetchProductData(productId: product.productId) { fetchedProductDetails in
                                    DispatchQueue.main.async {
                                        if let fetchedProductDetails = fetchedProductDetails {
                                            self.productDetailsList.append(fetchedProductDetails)
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


/*
struct LoginView: View {
    // Binding-variabel er brukt fordi den hentes fra en ennen struct, variablen er brukt for å holde oversikt over om brukeren er logget inn eller ikke.
    @Binding var isLoggedIn: Bool
    // StateObject for å hente data fra API
    @StateObject var dataFetcher = DataFetcher()
    // State-variabler for å lagre brukernavn og passord
    @State var username = ""
    @State var password = ""
    @State var email = ""
    @State var users = [Users]()
    // State-variabel for å vise feilmelding dersom innlogging mislykkes
    @State var showAlert = false
    // State-variabel for å lagre matchet bruker (men har egentlig ganske samme funskjon som users)
    
    @State var matchedUser: Users?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                //Her setter jeg opp to tekst felt ett der man skirver inn brukernavn og ett der man skirver inn passord
                VStack(alignment: .leading, spacing: 4) {
                    Text("Email or Username")
                        .font(.headline)
                    TextField("Enter your email or username", text: $username) // pass på $username, den trenger vi senre.
                        .autocapitalization(.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("Password")
                        .font(.headline)
                    SecureField("Enter your password", text: $password) // pass på $passord, den trenger vi senre.
                        .autocapitalization(.none)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                // dette er også debuging kode så det kan ignoreres
                Text("m38rmF$")
                Text("Johnd")
                // her setter jeg opp logiken bak innloggigen.
                Button(action: {
                    // her filtreres brukerlisten (hentet fra APIet) for å finne brukere som matcher brukernavnet eller e-post som er satt inn i tekst feltet over.
                    // dataFetcher.users er en array av Users objekter fetched som er hentet fra dataFetcher (der jeg henter fra APIet).
                    // filter { } brukes så for å skure igjennom "User" ((@State var users = [Users])). Filterfunksjonen returnerer deretter en ny array, men denne inneholder bare elementene som oppfyller de betingelse som er spesifisert. I dette tilfelle er dette de som har er bruker navn som er satt til "Johnd" og et passord som er "m38rmF$".
                    // vær OBS: $0 brukes bare for å representere det gjeldende elementet i listen som behandles, så det osm ble skrevet inn i "Text()".
                    // vær OBS: "$0.email == username", sier bare essensielt at selv om man har skrevet in e-mail så skal fortsat "$username" (John), legges legges inn i "matchingUsers"
                    let matchingUsers = dataFetcher.users.filter { $0.username == username || $0.email == username }
                    // etter at man trykker på "login" knappen sjekker man her om "matchingUser" er det samme som "matchedUser". (matchingUser definierte vi akkurat så det vet vi er en liste som inkluderer brukernavnet [johnd]. Vi vet at det bare er en mulig i denne listen til en hver tid så vi kan derfor bruke .first for å hente ut den første og eneste brukeren.)
                    // , men denne linjen gjør jo også noe mer, den sjekker også om det som var skrevet inn her: "SecureField("Enter your password", text: $password)", altså passordet, er det samme som passordet som er hentet fra APIen.
                    // vær OBS password og password er ikke det samme, dette er fordi den sjekker "matchedUser.password", med "password". Du kan tenke på matchedUser.password som en overfolder med en underfolder, dette gjør at "password" som bare er i overfolderen ikke kan snakke med "password" som bare er i underfolderen.
                    if let matchedUser = matchingUsers.first, matchedUser.password == password {
                        // her settes bare en statement til true, det er dette som lar oss logge inn.
                        isLoggedIn = true
                        self.matchedUser = matchedUser
                        // disse settes til "" ettersom username og passord fortsatt er fylt inn hvis man trykker tilbake uten at man gjør dette.
                        username = ""
                        password = ""
                        
                    } else {
                        // her gjøres essensielt akkurat det samme, mne med e-mail i stedenfor brukernavn. Dette er bare en 'nesta' if settning. Den sjekker først om man har riktig brukernavn og passord, etter dette sjekker den om man har riktig e-mail og passord. Hvis en av dem er riktig kan man logge inn, hvis ingen av dem er riktig kan man ikke det.
                        let matchingEmail = dataFetcher.users.filter { $0.email == email }
                        if let matchedEmailUser = matchingEmail.first, matchedEmailUser.password == password { isLoggedIn = true
                            self.matchedUser = matchedEmailUser
                            username = ""
                            password = ""
                            
                        } else {
                            // det er dette som skjer hvis man ikke har rett. En alert vises. "Alert" koden kan finnes i ".alert(isPresented: $showAlert) {".
                            self.showAlert = true }
                        
                    }
                    
                }) {
                    // Her styler vi bare knappen
                    Text(isLoggedIn ? "Logout" : "Login")
                        .padding(.vertical, 13)
                        .padding(.horizontal, 16)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    
                }
                // her er koden for "alerten". Veldig basic, har bare en tittel, litt tekst og en ok knapp, men man trenger ikke noe mer enn det. :)
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("Incorrect Username/Email or Password"), dismissButton: .default(Text("OK")))
                    
                }
                // noe viktig man må gjøre før man kjører logg inn logiken, er å sjekke om man allerede er logget inn. Dette gjørs her. "if isLoggedIn = true" (" = true" droppes fordi "isLoggedIn" er true.) 
                if isLoggedIn {
            // her sendes man bare til "ProfileView", som er der man ser info om brukeren.
                    NavigationLink(destination: ProfileView(isLoggedIn: $isLoggedIn, matchedUser: $matchedUser)) {
                        Text("Go to Profile")
                        
                    }
                    
                }
                
            }
            .padding(.horizontal, 24)
            // og viktigst av alt (kanskje) er denne, hvis man ikke henter noe data kan man ikke få gjort noe av dette.
            .onAppear {
                print("LoginView Appeared")
                dataFetcher.fetchUsers()
                print(dataFetcher)
                print(dataFetcher.fetchUsers)
                
            }
            
        }
        
    }
    
}*/
 

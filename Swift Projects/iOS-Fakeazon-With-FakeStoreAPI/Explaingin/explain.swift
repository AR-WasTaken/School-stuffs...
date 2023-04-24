/*//
//  explain.swift
//  iOS-NetStore-With-API
//
//  Created by Max Christopher Romslo Schulstock on 02/04/2023.
//

import Foundation
import SwiftUI


//Product: Denne strukturen representerer et produkt i butikken og inneholder informasjon om produktet, for eksempel ID, tittel, pris, beskrivelse, kategori, bildeadresse og vurderingsinformasjon. Product-strukturen er også Codable og Identifiable, som gjør det enkelt å dekode fra og kode til JSON og bruke i SwiftUI-views.
                                                                                                            
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

//Users: Denne strukturen representerer en bruker i applikasjonen og inneholder informasjon om brukeren, for eksempel ID, brukernavn, passord, e-post, telefon, navn og adresse. Variabelene name og address er valgfrie, noe som betyr at de kan være nil. Users-strukturen er også Codable og Identifiable, som gjør det enkelt å dekode fra og kode til JSON og bruke i SwiftUI-views.

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
//Cart: Denne strukturen representerer en handlekurv i applikasjonen og inneholder informasjon om handlekurven, for eksempel ID, bruker-ID, dato og en liste over produkter. Hvert produkt i handlekurven representeres av en egen struktur Product som inneholder produktets ID og mengde. Cart-strukturen er Codable, noe som gjør det enkelt å dekode fra og kode til JSON.
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

// ProductDetails: Denne strukturen er lik Product, men den brukes i en annen kontekst.

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
    // fetchData-funksjonen henter handlekurvdata for en gitt bruker og passerer den til en fullføringshåndterer.
    static func fetchData(userId: Int, completion: @escaping (Cart?) -> Void) {
        // Lag en URL-streng basert på brukerens ID
        let urlString = "https://fakestoreapi.com/carts/\(userId)"

        // Sjekk om URL-strengen er gyldig og konverter den til et URL-objekt
        guard let url = URL(string: urlString) else {
            print("Ugyldig URL")
            completion(nil)
            return
        }

        // Opprett en URLSession dataoppgave med URL-en
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Sjekk om det er noen data returnert fra URLSession dataoppgaven
            if let data = data {
                // Opprett en JSON-dekoder
                let decoder = JSONDecoder()
                do {
                    // Prøv å dekode dataene til et Cart-objekt
                    let fetchedData = try decoder.decode(Cart.self, from: data)
                    print("Hentet handlekurvdata: \(fetchedData)")
                    // Send de dekodede dataene til fullføringshåndtereren
                    completion(fetchedData)
                } catch {
                    // Hvis det er en feil ved dekoding av dataene, skriv ut feilen og send nil til fullføringshåndtereren
                    print("Feil ved dekoding av data: \(error)")
                    completion(nil)
                }
            } else {
                // Hvis det er en feil ved henting av dataene eller hvis det ikke er noen data, skriv ut feilen og send nil til fullføringshåndtereren
                print("Feil ved henting av data: \(error?.localizedDescription ?? "Ukjent feil")")
                completion(nil)
            }
        }.resume() // Start URLSession dataoppgaven
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

// Nå over til ContentView: Dette er hovedstrukturen for applikasjonen og inneholder en TabView med tre faner: "Home", "Cart" og "Profile". Den holder også informasjon om den innloggede brukeren og innloggingsstatusen.
// ContentView er essentiselt brukt som en hub for sende en bruker til riktig sted.

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var isLoggedIn = false
    @State var matchedUser: Users?
    
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
                CartView(userId: matchedUser?.id, isLoggedIn: $isLoggedIn)
                    .tabItem {
                        Image(systemName: "cart")
                        Text("Cart")
                    }
                    .tag(1)
                LoginView(isLoggedIn: $isLoggedIn, dataFetcher: dataFetcher, matchedUser: $matchedUser)
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
                    .tag(2)
            }
        }
    }
}

// Rask overview, hva gjør ProductView: Jo Dette Viewet viser en liste over produkter, og brukeren kan filtrere produktene basert på kategori ved å trykke på kategoriene som vises øverst i Viewet. Når Viewet vises, henter det produktdata ved hjelp av dataFetcher og filtrerer produktene basert på den valgte kategorien.
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
                // Det er her vi går til product detailview
                List(filteredProducts()) { product in
                    NavigationLink(destination: ProductDetailView(product: product)) {
                        ProductRowView(product: product)
                    }
                }
                // her henter vi dataen i dataFetcher
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

// Hva gjør BorderedProminentOrBordered. Jo dette er 110% min egen kode som jeg har laget helt selv, (takk stein), men denne sturcten er en knappstil som brukes for å gi en knappestil til  kategoriene i ProductView. Og den gjør at knappen endrer utseende basert på om kategorien er valgt eller ikke.

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


// ProductRowView: Dette er et View som representerer et enkelt produkt i en liste over produkter. Det viser produktets bilde, tittel og pris. Med noe styeling.

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

// ProductDetailView: Dette Viewet viser mer detaljert informasjon om et produkt, men bare etter at en bruker trykker på et produkt i ProductView. Etter at et produktet har blitt trykket på navigeres de til ProductDetailView-strukturen, som viser mye mer detaljert info om produktet produktet slik som bilde, tittel, pris, som man allerede viste, men også en beskrivelse av produktet samt, kategori og rateing.

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


//  CartView-strukturen tar to parametere: userId, som er et valgfritt heltall og representerer brukerens ID, og den ble defininert her i ContentView: "userId: matchedUser?.id". CartView structen tar også inn paramteren isLoggedIn, som er en binær variabel som angir om brukeren er logget inn eller ikke. Jeg kan ikke akkurat si så mye mo hvordan den fungerer enda, men men det er mer om den når vi kommer til LoginView.

struct CartView: View {
    let userId: Int?
    @Binding var isLoggedIn: Bool
    
    // To state variabler: cart og productDetailsList. cart innholder overaskende nok Carten for den innloggede brukeren, mens productDetailsList inneholder en liste med den detaljerte produktinformasjon for hvert produkt i handlekurven.
    
    @State private var cart: Cart?
    @State private var productDetailsList: [ProductDetails] = []
    
    // bodyen inneholder en NavigationView med en VStack, som igjen innholder en if statment som sjekker om brukeren er logget inn eller ikke. Hvis brukeren ikke er logget inn, får man en innloggingsfeil, men over til 'the cart logic'.
    
    var body: some View {
        NavigationView {
            VStack {
                if !isLoggedIn {
                    Text("Please log in :)")
                } else {
                    cartContent
                }
            }
            .navigationTitle("Cart")
            .onAppear(perform: loadCartData)
        }
    }
    
    //cartContent inneholder en en ScrollView med en VStack som inneholder cart innholdet. Hvis cart-variabelen ikke er nil, vil den vise carten ved å iterere gjennom productDetailsList og vise hvert produkt ved hjelp av cartItem-funksjonen. Elers visese dette: **MARKER LODAING DATA**
    
    private var cartContent: some View {
        ScrollView {
            VStack {
                if cart != nil {
                    ForEach(productDetailsList, id: \.id) { productDetails in
                        cartItem(productDetails: productDetails)
                    }
                } else {
                    Text("Loading data...")
                }
            }
        }
    }
    
    // cartItem-funksjonen tar en ProductDetails-parameter og returnerer et View som viser produktets bilde, tittel og pris. Det er essensielt det samme som i ProductRowView. Den viser bare et bilde litt tekst og hva det koster.
    
    private func cartItem(productDetails: ProductDetails) -> some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: URL(string: productDetails.image)) { image in
                    image.resizable().aspectRatio(contentMode: .fit).frame(width: 80.0)
                } placeholder: {
                    ProgressView()
                }
                
                VStack(alignment: .leading) {
                    Text(productDetails.title).font(.headline)
                    Text("$\(productDetails.price, specifier: "%.2f")").foregroundColor(.gray)
                }
                .padding(.vertical, 30)
            }
            .padding(.horizontal, 20)
            
            Divider()
        }
    }
    
    // loadCartData-funksjonen laster handlekurvdata for den innloggede brukeren ved å kalle dataFetcherCart som vi lagde her oppe, men den bruker brukerens id. Når dataene er hentet, oppdateres cart-variabelen med noe av den informasjonen vi hentet.
    
    private func loadCartData() {
        // Sjekker om bruker-ID er tilgjengelig
        if let userId = self.userId {
            // Henter handlekurvens data for brukeren ved bruker-ID
            dataFetcherCart.fetchData(userId: userId) { fetchedData in
                // Oppdaterer brukergrensesnittet på hovedtråden
                DispatchQueue.main.async {
                    // Lagrer hentede handlekurvdata i @State variabelen 'cart'
                    self.cart = fetchedData
                    
                    // Hvis det finnes produkter i handlekurven, hent produktdata
                    if let products = fetchedData?.products {
                        for product in products {
                            // Henter produktdata for hvert produkt i handlekurven
                            dataFetcherCart.fetchProductData(productId: product.productId) { fetchedProductDetails in
                                // Oppdaterer brukergrensesnittet på hovedtråden
                                DispatchQueue.main.async {
                                    // Hvis produktdataene er hentet, legg til i 'productDetailsList'
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
    
    
    //LoginView: Denne strukturen er ansvarlig for å vise innloggingsgrensesnittet, håndtere brukerinndata og administrere autentiseringsprosessen.

struct LoginView: View {
    // Binding som indikerer om brukeren er logget inn eller ikke
    @Binding var isLoggedIn: Bool
    
    // StateObject som inneholder metoder for å hente brukerdata
    @StateObject var dataFetcher = DataFetcher()
    
    // Brukerens innskrevne brukernavn eller e-postadresse
    @State var username = ""
    
    // Brukerens innskrevne passord
    @State var password = ""
    
    // State for å holde en liste over hentede brukere
    @State var users = [Users]()
    
    // State for å kontrollere visning av feilmeldingsdialog
    @State var showAlert = false
    
    // Binding som holder den matchede brukeren etter en vellykket innlogging
    @Binding var matchedUser: Users?
     
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // Rask innlogging for to forhåndsdefinerte brukere
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
                // Tekstfelt for å skrive inn brukernavn/e-post og passord
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

                // Innloggingsknapp som sjekker om inndataene samsvarer med en bruker i databasen
                // men denne delen er faktisk litt viktig så kanskej en litt mer in depth forklaring er smart.
                // let matchingUsers = dataFetcher.users.filter { $0.username == username || $0.email == username }: Denne linjen filtrerer listen over brukere som er hentet fra dataFetcher. Den sjekker om brukernavnet eller e-postadressen som er skrevet inn i tekstfeltet, samsvarer med brukernavnet eller e-postadressen til en bruker i listen.
                Button(action: {
                    let matchingUsers = dataFetcher.users.filter { $0.username == username || $0.email == username }
                    
                    //if let matchedUser = matchingUsers.first, matchedUser.password == password {: Denne IFen sjekker to ting: om det finnes minst én bruker i matchingUsers-listen (ved å sjekke om .first-elementet eksisterer), og om passordet til denne brukeren samsvarer med passordet som er skrevet inn i tekstfeltet.
                        
                    if let matchedUser = matchingUsers.first, matchedUser.password == password {
                        
                        // etter dette forklarer egentlig koden seg selv, isLoggedIn settes til true. også blir Den nåværende matchede brukeren lagret i matchedUser-variabelen.
                        
                        isLoggedIn = true
                        self.matchedUser = matchedUser
                        
                        // Og tilslutt tømmes tekstfeltene
                        
                        username = ""
                        password = ""
                    } else {
                        // hvis dette er feil så vises en allert.
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
                
                // Her er allerten for feilmeldingen som vises hvis brukeren skriver inn feil inndata
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text("Incorrect Username/Email or Password"), dismissButton: .default(Text("OK")))
                }
                
                // NavigationLink som går til profilvisningen hvis brukeren er logget inn, sier også seg selv.
                if isLoggedIn {
                    NavigationLink(destination: ProfileView(isLoggedIn: $isLoggedIn, matchedUser: $matchedUser)) {
                        Text("Go to Profile")
                    }
                }
            }
            .padding(.horizontal, 24)
            .onAppear {
                // Henter brukerdata når LoginView vises
                print("LoginView Appeared")
                dataFetcher.fetchUsers()
                print(dataFetcher)
                print(dataFetcher.fetchUsers)
            }
        }
    }
}

        struct ProfileView: View {
            // Bindende variabler for innloggingsstatus og brukerinformasjon
            @Binding var isLoggedIn: Bool
            @Binding var matchedUser: Users?
            @State var showAlert = false // Tilstandsvariabel for å styre visning av varsel
            
            // Hovedvisning for ProfileView
            var body: some View {
                NavigationView {
                    VStack {
                        // Vis brukerprofilen hvis brukeren er logget inn
                        if isLoggedIn {
                            if let matchedUser = matchedUser {
                                displayUserInfo(for: matchedUser)
                            }
                        } else {
                            // Vis en melding når brukeren ikke er logget inn
                            Text("You are not logged in")
                        }
                        
                        Spacer() // Fleksibel tom plass for å skyve innholdet mot toppen
                    }
                }
            }
            
            // Hjelpefunksjon for å vise brukerinformasjon i en liste
            private func displayUserInfo(for user: Users) -> some View {
                List {
                    VStack(alignment: .center, spacing: 16) {
                        // Vis brukerens navn
                        if let name = user.name {
                            Text("\(name.firstname) \(name.lastname)")
                                .font(.largeTitle)
                                .autocapitalization(.none)
                        }
                        // Vis brukerens e-post
                        Text("Email")
                            .font(.headline)
                        Text(user.email)
                            .font(.body)
                            .foregroundColor(.gray)
                        
                        // Vis brukerens lokasjon (by)
                        Text("Location")
                            .font(.headline)
                        Text(user.address?.city ?? "")
                            .font(.body)
                            .foregroundColor(.gray)
                        
                        // Vis brukerens gate og postnummer
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
                        
                        // Vis brukerens telefonnummer
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
        ContentView(userId: 0)
    }
}
*/

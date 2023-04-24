//
//  ContentView.swift
//  03.03 API Todos-Liste
//
//  Created by M on 03/03/2023.
//

import SwiftUI
import Foundation

struct Todo: Codable, Identifiable {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}


func getTodo(urlString: String) async throws -> [Todo] {
    let url = URL(string: urlString)!
    let urlrequest = URLRequest(url: url)
    
    let (data, _) = try await URLSession.shared.data(for: urlrequest)
    let svar = try JSONDecoder().decode([Todo].self, from: data)
    return svar
}


struct ContentView: View {
    @State var todoer: [Todo] = []
    
    

    var body: some View {
        NavigationStack {
            List(todoer) { todo in
                NavigationLink(destination: TodoView(todo: todo)) {
                    

                    
                    Text(todo.title)
                }
                
            }
            .navigationTitle("Todos")
        }
        .task {
            do {
                todoer = try await getTodo(urlString: "https://jsonplaceholder.typicode.com/todos/")
            }
            catch {
                print(error.localizedDescription)
            }
        }
        .refreshable {
            do {
                todoer = try await getTodo(urlString: "https://jsonplaceholder.typicode.com/todos/")
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct TodoView: View {
    @State var todoDone: Bool
    
    var todo: Todo
    init(todo: Todo) {
            self.todo = todo
            self._todoDone = State(initialValue: todo.completed)
        }
    
    var body: some View {
        VStack {
            Text(todo.title).font(.title)
            
            if todoDone {
                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: 320.0, height: 320.0)
                    } else {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 320.0, height: 320.0)
                    }
            
            //Text(String(todo.completed)).font(.body)
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

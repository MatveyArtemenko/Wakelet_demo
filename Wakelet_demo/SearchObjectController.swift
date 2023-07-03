//
//  SearchObjectController.swift
//  Wakelet_demo
//
//  Created by admin on 27/04/2023.
//

import Foundation

class SearchObjectController: ObservableObject {
    static let shared = SearchObjectController()
    
    private init() { search() }
    
    let token = "JX5xSRIM66FjmBcuXwAMWDysGYXbXd_9-O2NfY_Oc8c"
    @Published var results = [Result]()
    @Published var searchText: String = ""
    
    func search() {
        let url = URL(string: "https://api.unsplash.com/search/photos?query=\(searchText.isEmpty ? "random" : searchText)")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        request.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                do {
                    self.results.removeAll()
                    let decoded = try JSONDecoder().decode(Results.self, from: data)
                    self.results.append(contentsOf: decoded.results)
                    
                } catch {
                    print("unsplash error \(error)")
                }
            }
        }
        task.resume()
    }
}

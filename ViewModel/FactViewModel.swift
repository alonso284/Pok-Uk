//
//  SwiftUIView.swift
//  Pok’Uk
//
//  Created by Alonso Huerta on 21/02/25.
//

import SwiftUI

// Define the model to match the structure of the JSON
struct Fact: Codable {
//    var id: UUID = UUID()
    var fact: String
    var answer: Bool
    var right: String
    var wrong: String
}

// ViewModel for loading the JSON data
class FactViewModel: ObservableObject {
    @Published var facts: [Fact] = []
    
    init() {
        loadFacts()
    }
    
    func loadFacts() {
        // Load JSON file from the app's resources
        guard let url = Bundle.main.url(forResource: "trivia", withExtension: "json") else {
            print("Error: Could not find facts.json file in resources")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decodedFacts = try decoder.decode([Fact].self, from: data)
            self.facts = decodedFacts
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    
    func getRandomFact() -> Fact? {
        guard !facts.isEmpty else { return nil }
        let randomIndex = Int.random(in: 0..<facts.count)
        return facts[randomIndex]
    }
}

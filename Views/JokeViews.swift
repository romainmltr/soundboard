//
//  JokeViews.swift
//  SoudboardQuizz
//
//  Created by Malaterre Romain on 22/11/2023.
//
import Foundation
import SwiftUI

struct JokeView: View {
    @State private var joke: Joke?
    @State private var selectedCategory: String = "Programming"
    @State private var selectedLanguage: String = "en"
    @State private var categories = ["Programming", "Miscellaneous", "Dark", "Pun", "Spooky", "Christmas"]
    @State private var languages = ["en", "fr", "de", "es", "it"]
    @State private var isLoading: Bool = false

    var body: some View {
        VStack {
            Picker("Category", selection: $selectedCategory) {
                ForEach(categories, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            Picker("Language", selection: $selectedLanguage) {
                ForEach(languages, id: \.self) {
                    Text($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            if isLoading {
                ProgressView()
            } else if let joke = joke {
                Text(joke.setup)
                    .padding()
                Text(joke.delivery)
                    .padding()

                Button("Random") {
                    // Rechargez une nouvelle blague lorsque le bouton "Random" est appuyé
                    loadJoke()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(5)
            }
        }
        .onAppear {
            // Chargez une blague lors de l'apparition de la vue
            loadJoke()
        }
    }

    private func loadJoke() {
        guard let url = URL(string: "https://v2.jokeapi.dev/joke/\(selectedCategory)?lang=\(selectedLanguage)") else {
            print("URL invalide")
            return
        }

        isLoading = true  // Activez l'indicateur de chargement

        URLSession.shared.dataTask(with: url) { data, _, error in
            defer {
                isLoading = false  // Désactivez l'indicateur de chargement même en cas d'erreur
            }

            guard let data = data, error == nil else {
                print("Erreur de chargement des données : \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let decoder = JSONDecoder()
                joke = try decoder.decode(Joke.self, from: data)
            } catch {
                print("Erreur de décodage : \(error)")
            }
        }
        .resume()
    }
}

struct Joke: Codable {
    let setup: String
    let delivery: String
}

struct JokeView_Previews: PreviewProvider {
    static var previews: some View {
        JokeView()
    }
}

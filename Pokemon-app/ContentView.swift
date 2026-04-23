//
//  ContentView.swift
//  Pokemon-app
//
//  Created by rafa mercado on 4/8/26.
//

import SwiftUI

struct ContentView: View {
    @State private var pokemon: [PokemonEntry] = []
    @State private var isLoading = true
    private let service = PokeAPIService()

    var body: some View {
        NavigationStack {
            Group {
                if isLoading {
                    ProgressView("Loading Pokemon...")
                } else {
                    List(pokemon) { entry in
                        HStack(spacing: 12) {
                            AsyncImage(url: entry.imageURL) { image in
                                image.resizable().scaledToFit()
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 60, height: 60)

                            VStack(alignment: .leading) {
                                Text(entry.name.capitalized)
                                    .font(.headline)
                                Text("#\(entry.id)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Pokedex")
        }
        .task {
            do {
                pokemon = try await service.fetchPokemonList()
                isLoading = false
            } catch {
                isLoading = false
                print("Failed to load: \(error)")
            }
        }
    }
}

#Preview {
    ContentView()
}

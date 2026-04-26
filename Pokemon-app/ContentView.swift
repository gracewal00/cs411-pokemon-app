//
//  ContentView.swift
//  Pokemon-app
//
//

import SwiftUI

struct ContentView: View {
    @State private var pokemon: [PokemonEntry] = []
    @State private var isLoading = true
    @State private var searchText = ""
    private let service = PokeAPIService()

    var filteredPokemon: [PokemonEntry] {
        if searchText.isEmpty {
            return pokemon
        } else {
            return pokemon.filter { entry in
                entry.name.lowercased().contains(searchText.lowercased())
            }
        }
    }

    var body: some View {
        Group {
            if isLoading {
                ProgressView("Loading Pokemon...")
            } else {
                List(filteredPokemon) { entry in
                    NavigationLink(destination: PokemonInfoView(pokemonName: entry.name)) {
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
                .overlay {
                    if filteredPokemon.isEmpty && !searchText.isEmpty {
                        ContentUnavailableView.search(text: searchText)
                    }
                }
            }
        }
        .navigationTitle("Pokedex")
        // New fix,This forces the top bar and back button to stay visible while searching
        .navigationBarTitleDisplayMode(.inline)
        // New fix, to prevent getting stuck in page after usign search bar. Moved outside the List and removed the forced placement bug
        .searchable(text: $searchText, prompt: "Search Pokémon")
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

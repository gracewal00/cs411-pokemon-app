//
//  PokemonInfoView.swift
//  Pokemon-app
//
//  Created by Gilbert Cervantes
//

import SwiftUI

struct PokemonInfoView: View {
    // This get's our global data variables/attributes so we can save Pokemon to it
    @Environment(TeamManager.self) var teamManager

    // The name of the Pokémon the user typed in
    let pokemonName: String
    
    // set variables/attributes to keep track or scan what is actively running or executed
    @State private var pokemon: PokemonDetail?
    @State private var isLoading = true
    @State private var errorMessage = ""
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if isLoading {
                    ProgressView("Searching the tall grass...")
                        .padding(.top, 100)
                }
                else if !errorMessage.isEmpty {
                    Text("Oops! " + errorMessage)
                        .foregroundColor(.red)
                }
                else if let pokemon = pokemon {
                    // Show the Pokémon's name at the top in big letters, and the ID number below it (like #001)
                    VStack(spacing: 4) {
                        Text(pokemon.name.capitalized)
                            .font(.largeTitle)
                            .bold()
                        // Format the id with zeros in front so it looks like #001 instead of #1
                        Text(String(format: "#%03d", pokemon.id))
                            .font(.title3)
                            .foregroundStyle(.secondary)
                    }

                    // Try to get the nicer official artwork image first.
                    // If that doesn't exist for some reason, just use the regular sprite as a backup.
                    var artworkURL: String? = pokemon.sprites.frontDefault
                    if let officialArt = pokemon.sprites.other?.officialArtwork?.frontDefault {
                        artworkURL = officialArt
                    }

                    // Load and show the image from the URL we picked above
                    if let urlString = artworkURL, let url = URL(string: urlString) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 220, height: 220)
                        } placeholder: {
                            // Show a spinner while the picture is loading
                            ProgressView()
                                .frame(width: 220, height: 220)
                        }
                    }

                    // Show the Pokémon's types as colored pills (like Fire in red, Water in blue, etc.)
                    // A Pokémon can have 1 or 2 types, so we loop through them
                    HStack(spacing: 10) {
                        ForEach(pokemon.types, id: \.type.name) { typeSlot in
                            Text(typeSlot.type.name.capitalized)
                                .font(.subheadline)
                                .bold()
                                .padding(.horizontal, 16)
                                .padding(.vertical, 6)
                                .background(typeColor(for: typeSlot.type.name)) // pick a color based on type name
                                .foregroundColor(.white)
                                .clipShape(Capsule()) // rounded pill shape
                        }
                    }

                    // Show height and weight side by side
                    // The API gives us height in decimeters and weight in hectograms (weird units)
                    // so we divide by 10 to convert to meters and kilograms
                    HStack(spacing: 40) {
                        VStack {
                            Text("Height")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text("\(Double(pokemon.height) / 10, specifier: "%.1f") m")
                                .font(.headline)
                        }
                        VStack {
                            Text("Weight")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Text("\(Double(pokemon.weight) / 10, specifier: "%.1f") kg")
                                .font(.headline)
                        }
                    }
                    .padding(.vertical, 8)

                    // Show the Pokémon's base stats (HP, Attack, Defense, etc.) with a progress bar for each
                    // This way the user can see which stats are strong and which are weak at a glance
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Base Stats")
                            .font(.headline)
                        ForEach(pokemon.stats, id: \.stat.name) { stat in
                            HStack {
                                // The name of the stat (like "hp" or "attack")
                                Text(stat.stat.name.capitalized)
                                    .frame(width: 120, alignment: .leading)
                                    .font(.subheadline)
                                // The actual number value
                                Text("\(stat.baseStat)")
                                    .font(.subheadline)
                                    .bold()
                                    .frame(width: 40, alignment: .trailing)
                                // Progress bar — 200 is about the max a stat can be
                                ProgressView(value: Double(stat.baseStat), total: 200)
                                    .tint(.green)
                            }
                        }
                    }
                    .padding(.horizontal)

                    // Button to add this Pokémon to the user's team (now bigger and full-width so it's easier to tap)
                    Button {
                        // Make a new TeamMember from this Pokémon and save it to the team
                        let newTeammate = TeamMember(id: pokemon.id, name: pokemon.name, spriteURL: pokemon.sprites.frontDefault)
                        teamManager.addToTeam(pokemon: newTeammate)
                    } label: {
                        Text("Add to Team")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                }
            }
            .padding()
        }
        .navigationTitle("Pokédex Data")
        .task {
            await getPokemonData()
        }
    }

    // Helper function to pick a color for each Pokémon type
    // For example, Fire types should look red, Water types blue, etc.
    // This makes the type badges look more like the real Pokémon games
    func typeColor(for typeName: String) -> Color {
        switch typeName.lowercased() {
        case "fire": return .red
        case "water": return .blue
        case "grass": return .green
        case "electric": return .yellow
        case "psychic": return .pink
        case "ice": return .cyan
        case "dragon": return .purple
        case "dark": return .black
        case "fairy": return .pink
        case "normal": return .gray
        case "fighting": return .orange
        case "flying": return .teal
        case "poison": return .purple
        case "ground": return .brown
        case "rock": return .brown
        case "bug": return .green
        case "ghost": return .indigo
        case "steel": return .gray
        // If we don't recognize the type, just use gray as a default
        default: return .gray
        }
    }
    
    // This function will allow us to scan through our NetworkManager and retrieves the actual running data
    func getPokemonData() async {
        do {
            let data = try await PokeAPIService().fetchPokemon(name: pokemonName)
            pokemon = data
            isLoading = false
        } catch {
            errorMessage = "Could not find that Pokémon."
            isLoading = false
        }
    }
}

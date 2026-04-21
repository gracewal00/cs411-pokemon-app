//
//  PokemonInfoView.swift
//  Pokemon-app
//
//  Created by Gilbert Cervantes
//

import SwiftUI

struct PokemonInfoView: View {
    // This get's our global data variables/attributes so we can save Pokemon to it
    @EnvironmentObject var teamManager: TeamManager

    // The name of the Pokémon the user typed in
    let pokemonName: String
    
    // set variables/attributes to keep track or scan what is actively running or executed
    @State private var pokemon: PokemonDetail?
    @State private var isLoading = true
    @State private var errorMessage = ""
    
    var body: some View {
        VStack(spacing: 20) {
            // just a progress or buffer bar for the page to load and show user
            if isLoading {
                ProgressView("Searching the tall grass...")
            }
            // in this case, if the user types a false/fake name it'll send an error message
            else if !errorMessage.isEmpty {
                Text("Oops! " + errorMessage)
                    .foregroundColor(.red)
            }
            // If/when we found the Pokemon it will show the corresponding information
            else if let pokemon = pokemon {
                Text(pokemon.name.capitalized)
                    .font(.largeTitle)
                    .bold()
                
                // get's the Pokemon's picture from the internet/network
                if let spriteUrl = pokemon.sprites.frontDefault, let url = URL(string: spriteUrl) {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                    } placeholder: {
                        ProgressView() // Spinner while the image loads
                    }
                }
                
                // Just a button to save this Pokémon to our team
                Button {
                    // Create a team member and save it
                    let newTeammate = TeamMember(id: pokemon.id, name: pokemon.name, spriteURL: pokemon.sprites.frontDefault)
                    teamManager.addToTeam(pokemon: newTeammate)
                } label: {
                    Text("Add to Team")
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
        }
        .navigationTitle("Pokédex Data")
        // Condintionally, when this desired screen is called to open it then runs our internet fetching function below
        .task {
            await getPokemonData()
        }
    }
    
    // This function will allow us to scan through our NetworkManager and retrieves the actual running data
    func getPokemonData() async {
        do {
            let data = try await NetworkManager().fetchPokemon(name: pokemonName)
            pokemon = data
            isLoading = false
        } catch {
            errorMessage = "Could not find that Pokémon."
            isLoading = false
        }
    }
}

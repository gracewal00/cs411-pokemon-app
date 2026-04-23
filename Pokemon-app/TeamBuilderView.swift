//
//  TeamBuilderView.swift
//  Pokemon-app
//

import SwiftUI

struct TeamBuilderView: View {
    @Environment(TeamManager.self) var teamManager

    var body: some View {
        VStack {
            if teamManager.team.isEmpty {
                Spacer()

                Image(systemName: "person.3.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.gray)

                Text("Your team is empty")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.top, 8)

                Text("Go to a Pokémon page and tap Add to Team.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                Spacer()
            } else {
                List {
                    Section("Team Members (\(teamManager.team.count)/6)") {
                        ForEach(teamManager.team) { pokemon in
                            HStack(spacing: 12) {
                                if let spriteURL = pokemon.spriteURL,
                                   let url = URL(string: spriteURL) {
                                    AsyncImage(url: url) { image in
                                        image
                                            .resizable()
                                            .scaledToFit()
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 70, height: 70)
                                } else {
                                    Image(systemName: "photo")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 70, height: 70)
                                        .foregroundColor(.gray)
                                }

                                VStack(alignment: .leading, spacing: 4) {
                                    Text(pokemon.name.capitalized)
                                        .font(.headline)

                                    Text("Pokémon #\(pokemon.id)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }

                                Spacer()

                                Button {
                                    teamManager.removeFromTeam(pokemon: pokemon)
                                } label: {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                .listStyle(.insetGrouped)
            }
        }
        .navigationTitle("Team Builder")
    }
}

#Preview {
    TeamBuilderView()
        .environment(TeamManager())
}

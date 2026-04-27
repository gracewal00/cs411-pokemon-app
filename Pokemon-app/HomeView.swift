//
//  HomeView.swift
//  Pokemon-app
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()

                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 90, height: 90)

                    Circle()
                        .trim(from: 0.0, to: 0.5)
                        .fill(Color.red)
                        .frame(width: 90, height: 90)
                        .rotationEffect(.degrees(180))

                    Rectangle()
                        .fill(Color.black)
                        .frame(width: 90, height: 8)

                    Circle()
                        .fill(Color.white)
                        .frame(width: 26, height: 26)
                        .overlay(
                            Circle()
                                .stroke(Color.black, lineWidth: 6)
                        )

                    Circle()
                        .fill(Color.white)
                        .frame(width: 10, height: 10)
                }

                Text("PocketDex")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("Browse Pokémon and build your team.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)

                NavigationLink {
                    ContentView()
                } label: {
                    Text("PocketDex")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }

                NavigationLink {
                    TeamBuilderView()
                } label: {
                    Text("Go to Team Builder")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                
                NavigationLink {
                    SettingsView()
                } label: {
                    Text("Settings")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Home")
            .background(.appBackground)
        }
    }
}

#Preview {
    HomeView()
}

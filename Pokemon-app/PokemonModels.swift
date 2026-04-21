//
//  PokemonModels.swift
//  Pokemon-app
//
//  Created by Gilbert Cervantes.
//

import Foundation

// Note, file is to handle the: Data Models
// Moreover, the data structure is referening apple's PetTricks learning module

// This collects and handles the data from the internet's raw JSON into a format that our app can handle/understand
struct PokemonData: Codable, Identifiable {
    let id: Int
    let name: String
    let sprites: Sprites
}

// Note, handles image etc,. : Image Data
// This scans/handles for the image or URLs from the API
struct Sprites: Codable {
    let frontDefault: String?
    
    
    // to consider that the web's API may call or handle the function as a different varaible such as: front_default. Whereas we have seen that Swift typically is camelCase.
    
    // This way we can use CodingKeys which acts the translator for both programs
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

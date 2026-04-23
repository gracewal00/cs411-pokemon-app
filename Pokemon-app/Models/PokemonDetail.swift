import Foundation

struct PokemonDetail: Codable, Identifiable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let types: [TypeSlot]
    let stats: [StatEntry]
    let sprites: Sprites
}

struct TypeSlot: Codable {
    let type: TypeInfo
}

struct TypeInfo: Codable {
    let name: String
}

struct StatEntry: Codable {
    let baseStat: Int
    let stat: StatInfo

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
}

struct StatInfo: Codable {
    let name: String
}

struct Sprites: Codable {
    let frontDefault: String?
    let other: OtherSprites?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case other
    }
}

struct OtherSprites: Codable {
    let officialArtwork: OfficialArtwork?

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Codable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

import Foundation

struct PokemonListResponse: Codable {
    let results: [PokemonEntry]
}

struct PokemonEntry: Codable, Identifiable {
    let name: String
    let url: String

    var id: Int {
        Int(url.split(separator: "/").last ?? "0") ?? 0
    }

    var imageURL: URL? {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(id).png")
    }
}

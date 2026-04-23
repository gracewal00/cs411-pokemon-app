import Foundation

class PokeAPIService {
    func fetchPokemonList() async throws -> [PokemonEntry] {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(PokemonListResponse.self, from: data)
        return response.results
    }

    func fetchPokemon(name: String) async throws -> PokemonDetail {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(name.lowercased())")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(PokemonDetail.self, from: data)
    }

    func fetchPokemonDetail(id: Int) async throws -> PokemonDetail {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(id)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode(PokemonDetail.self, from: data)
    }
}

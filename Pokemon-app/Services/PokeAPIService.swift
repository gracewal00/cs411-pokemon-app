import Foundation

class PokeAPIService {
    func fetchPokemonList() async throws -> [PokemonEntry] {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=151")!
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(PokemonListResponse.self, from: data)
        return response.results
    }
}

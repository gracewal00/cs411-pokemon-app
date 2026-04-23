import SwiftUI

struct TeamMember: Identifiable, Codable {
    let id: Int
    let name: String
    let spriteURL: String?
}

@Observable
class TeamManager {
    var team: [TeamMember] = []

    func addToTeam(pokemon: TeamMember) {
        // Limit team to 6 Pokemon
        guard team.count < 6 else { return }
        // Don't add duplicates
        guard !team.contains(where: { $0.id == pokemon.id }) else { return }
        team.append(pokemon)
    }

    func removeFromTeam(pokemon: TeamMember) {
        team.removeAll { $0.id == pokemon.id }
    }
}

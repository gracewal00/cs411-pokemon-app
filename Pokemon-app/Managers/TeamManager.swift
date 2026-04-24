import SwiftUI

struct TeamMember: Identifiable, Codable {
    let id: Int
    let name: String
    let spriteURL: String?
}

@Observable
class TeamManager {
    private let saveKey = "SavedTeam"
    
    var team: [TeamMember] = [] {
        didSet {
            save()
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([TeamMember].self, from: data) {
                team = decoded
                return
            }
        }
        team = []
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(team) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
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

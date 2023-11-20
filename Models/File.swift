import Foundation

class Sound: Identifiable {
    var id = UUID()
    var name: String
    var fileName: String
    var owner: String

    init(name: String, fileName: String, owner: String) {
        self.name = name
        self.fileName = fileName
        self.owner = owner
    }
    static func allSounds() -> [Sound] {
        return [
            Sound(name: "Hein.mp3", fileName: "Hein.mp3", owner: "Zemmour"),
        
        ]
    }
}

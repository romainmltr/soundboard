//
//  OnlySound.swift
//  SoudboardQuizz
//
//  Created by Malaterre Romain on 21/11/2023.
//

import Foundation

struct SoundOnly: Identifiable, Codable {
    let id: UUID
    let fileName: String

    init(fileName: String) {
        self.id = UUID()
        self.fileName = fileName
    }

    static func soundOnly() -> [SoundOnly] {
        return [
            SoundOnly(fileName: "BenVoyons.mp3"),
            SoundOnly(fileName: "tk78.mp3"),
            SoundOnly(fileName: "Hein.mp3"),
            SoundOnly(fileName: "Projet.mp3"),
            SoundOnly(fileName: "greg.mp3"),
            SoundOnly(fileName: "oss117.mp3"),
            SoundOnly(fileName: "reuf.mp3")
        ]
    }
}

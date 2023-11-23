//
//  UseSounds.swift
//  SoudboardQuizz
//
//  Created by Malaterre Romain on 21/11/2023.
//
import Foundation
import SwiftUI


class UserSoud: Identifiable {
    var id = UUID()
    var soundName: String?
    var fileName: String
    var soundOnlyObject: SoundOnly?

    init(fileName: String, soundName: String? = nil) {
        self.fileName = fileName
        self.soundName = soundName
        self.soundOnlyObject = UserSoud.getSoundOnlyObject(for: fileName)
    }

    static func userSounds() -> [UserSoud] {
        return [
            UserSoud(fileName: "BenVoyons.mp3", soundName: ""),
            UserSoud(fileName: "tk78.mp3", soundName: ""),
            UserSoud(fileName: "Hein.mp3", soundName: "")
        ]
    }

    private static func getSoundOnlyObject(for fileName: String) -> SoundOnly? {
        if let soundOnly = SoundOnly.soundOnly().first(where: { $0.fileName == fileName }) {
            return SoundOnly(fileName: soundOnly.fileName)
        }
        return nil
    }
}

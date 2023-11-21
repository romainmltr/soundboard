//
//  UseSounds.swift
//  SoudboardQuizz
//
//  Created by Malaterre Romain on 21/11/2023.
//
import Foundation


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
            UserSoud(fileName: "BenVoyons.mp3", soundName: "Test1"),
            UserSoud(fileName: "tk78", soundName: "Test2"),
            UserSoud(fileName: "Hein.mp3", soundName: "Test3")
        ]
    }

    private static func getSoundOnlyObject(for fileName: String) -> SoundOnly? {
        return SoundOnly.soundOnly().first { $0.fileName == fileName }
    }
}

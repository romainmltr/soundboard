//
//  UseSounds.swift
//  SoudboardQuizz
//
//  Created by Malaterre Romain on 21/11/2023.
//

import Foundation

class UserSoud: Identifiable {
    var id = UUID()
    var fileName: String

    init(fileName: String) {
        self.fileName = fileName
    }

    static func userSounds() -> [UserSoud] {
        return [
            UserSoud(fileName: "oss117"),
            UserSoud(fileName: "greg")
        ]
    }
}

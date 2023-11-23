//
//  UserSoundFormViews.swift
//  SoudboardQuizz
//
//  Created by Malaterre Romain on 21/11/2023.
//

import Foundation
import SwiftUI

struct UserSoundFormView: View {
    @State private var selectedSoundIndex = 0
    @State private var soundName = ""
    @Binding var userSounds: [UserSoud]


    var soundOnlyList: [SoundOnly] {
        userSounds.map { $0.soundOnlyObject! }
    }

    var body: some View {
        NavigationView {
            Form {
                Section("Select Sound") {
                    Picker("Select Sound", selection: $selectedSoundIndex) {
                        ForEach(0..<soundOnlyList.count, id: \.self) { index in
                            Text(self.soundOnlyList[index].fileName)
                        }
                    }
                }

                Section("Sound Information") {
                    TextField("Name", text: $soundName)
                }

                Section {
                    Button("Add Sound") {
                        addUserSound()
                    }
                }
            }
            .navigationBarTitle("Add User Sound")
        }
    }

    func addUserSound() {
        guard selectedSoundIndex < soundOnlyList.count else {
            return
        }

        let selectedSound = soundOnlyList[selectedSoundIndex]
        let userSound = UserSoud(fileName: selectedSound.fileName, soundName: soundName)
        userSounds.append(userSound)
        soundName = ""
    }
}

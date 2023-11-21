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
    @State private var userSounds: [UserSoud] = UserSoud.userSounds()

    var body: some View {
        NavigationView {
            Form {
                Section("Select Sound") {
                    Picker("Select Sound", selection: $selectedSoundIndex) {
                        ForEach(0..<SoundOnly.soundOnly().count) { index in
                            Text(SoundOnly.soundOnly()[index].fileName)
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
        guard selectedSoundIndex < SoundOnly.soundOnly().count else {
            return
        }

        let selectedSound = SoundOnly.soundOnly()[selectedSoundIndex]
        let userSound = UserSoud(fileName: selectedSound.fileName, soundName: soundName)

        userSounds.append(userSound)

        // Clear the form fields
        soundName = ""
    }
}

struct UserSoundFormView_Previews: PreviewProvider {
    static var previews: some View {
        UserSoundFormView()
    }
}


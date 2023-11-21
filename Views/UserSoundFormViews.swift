//
//  UserSoundFormViews.swift
//  SoudboardQuizz
//
//  Created by Malaterre Romain on 21/11/2023.
//

import Foundation
import SwiftUI

struct UserSoundsFormView: View {
    @State private var selectedSoundIndex = 0
    @State private var soundName = ""
    @Binding var userSounds: [UserSoud]

    var body: some View {
        NavigationView {
            Form {
                Section("Select Sound") {
                    Picker("Select Sound", selection: $selectedSoundIndex) {
                        ForEach(0..<userSounds.count) { index in
                            Text(userSounds[index].fileName)
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
        guard selectedSoundIndex < userSounds.count else {
            return
        }

        let selectedSound = userSounds[selectedSoundIndex]
        let userSound = UserSoud(fileName: selectedSound.fileName)

        // Add the new user sound to the userSounds array
        userSounds.append(userSound)

        // Clear the form fields
        soundName = ""
    }
}

struct UserSoundsFormView_Previews: PreviewProvider {
    static var previews: some View {
        UserSoundsFormView(userSounds: .constant([]))
    }
}

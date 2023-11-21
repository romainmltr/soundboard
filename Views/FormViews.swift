//
//  FormViews.swift
//  SoudboardQuizz
//
//  Created by Malaterre Romain on 20/11/2023.
//

import Foundation
import SwiftUI

struct FormViews: View {
    @State private var selectedSoundIndex = 0
    @State private var soundName = ""
    @State private var soundFileName = ""
    @State private var soundOwner = ""
    @State private var soundImageURL = ""
    @Binding var sounds: [Sound]


    var body: some View {
        NavigationView {
            Form {
                Section("Select Sound") {
                    Picker("Select Sound", selection: $selectedSoundIndex) {
                        ForEach(0..<sounds.count, id: \.self) { index in
                            Text(self.sounds[index].name)
                        }
                    }
                }

                Section("Sound Information") {
                    TextField("Name", text: $soundName)
        
                    TextField("Owner", text: $soundOwner)
                    TextField("Image URL", text: $soundImageURL)
                }

                Section {
                    Button("Add Sound") {
                        addSound()
                    }
                }
            }
            .navigationBarTitle("Add Sound")
        }
    }

    func addSound() {
        // Vérifiez que l'index sélectionné est valide
        guard selectedSoundIndex < sounds.count else {
            return
        }

        let selectedSound = sounds[selectedSoundIndex]
        let newSound = Sound(name: soundName, fileName: soundFileName, owner: soundOwner, imageURL: soundImageURL)

        // Vous pouvez faire ce que vous voulez avec le nouveau son et le son sélectionné ici

        // Réinitialisez les champs du formulaire
        soundName = ""
        soundFileName = ""
        soundOwner = ""
        soundImageURL = ""
    }
}

struct FormViews_Previews: PreviewProvider {
    static var previews: some View {
        FormViews(sounds: .constant([]))
    }
}

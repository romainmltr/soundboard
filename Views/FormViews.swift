//
//  FormViews.swift
//  SoudboardQuizz
//
//  Created by Malaterre Romain on 20/11/2023.
//

import Foundation
import SwiftUI

struct FormViews: View {
    @State private var soundName = ""
    @State private var soundFileName = ""
    @State private var soundOwner = ""
    @State private var soundImageURL = ""

    @Binding var sounds: [Sound]

    var body: some View {
        NavigationView {
            Form {
                Section("Sound Information") {
                    TextField("Name", text: $soundName)
                    TextField("File Name", text: $soundFileName)
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
        let newSound = Sound(name: soundName, fileName: soundFileName, owner: soundOwner, imageURL: soundImageURL)
        sounds.append(newSound)

        soundName = ""
        soundFileName = ""
        soundOwner = ""
        soundImageURL = ""
    }
}

struct SoundForm_Previews: PreviewProvider {
    static var previews: some View {
        FormViews(sounds: .constant([]))
    }
}

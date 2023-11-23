import Foundation
import SwiftUI
import AVFoundation

struct FavoriteViews: View {
    @Binding var userSounds: [UserSoud]
    @State private var selectedSoundIndex = 0
    @State private var soundName = ""
    @State private var audioPlayer: AVAudioPlayer?

    var soundOnlyList: [SoundOnly] {
        SoundOnly.soundOnly()
    }

    var body: some View {
        NavigationView {
            VStack {
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
                        Button(action: addUserSound) {
                            Label("Add Sound", systemImage: "plus.circle.fill")
                        }
                    }
                }

                List {
                    ForEach(userSounds, id: \.id) { userSound in
                        UserSoundCardView(userSound: userSound, playAction: {
                            playUserSound(userSound: userSound)
                        }, deleteAction: {
                            deleteUserSound(userSound: userSound)
                        })
                    }
                }
                .background(Color.clear)
            }
        }
        .onAppear {
            // Charger les données sauvegardées lors de l'apparition de la vue
            loadUserSounds()
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

        // Sauvegarder les données après l'ajout
        saveUserSounds()
    }

    func playUserSound(userSound: UserSoud) {
        if let soundURL = Bundle.main.url(forResource: userSound.fileName, withExtension: nil) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Error playing user sound: \(error.localizedDescription)")
            }
        }
    }

    func deleteUserSound(userSound: UserSoud) {
        if let index = userSounds.firstIndex(where: { $0.id == userSound.id }) {
            userSounds.remove(at: index)
            // Sauvegarder les données après la suppression
            saveUserSounds()
        }
    }

    // Charger les données sauvegardées depuis UserDefaults
    func loadUserSounds() {
        if let data = UserDefaults.standard.data(forKey: "userSounds") {
            do {
                userSounds = try JSONDecoder().decode([UserSoud].self, from: data)
            } catch {
                print("Error loading user sounds: \(error.localizedDescription)")
            }
        }
    }

    // Sauvegarder les données dans UserDefaults
    func saveUserSounds() {
        do {
            let data = try JSONEncoder().encode(userSounds)
            UserDefaults.standard.set(data, forKey: "userSounds")
        } catch {
            print("Error saving user sounds: \(error.localizedDescription)")
        }
    }
}

struct UserSoundCardView: View {
    let userSound: UserSoud
    let playAction: () -> Void
    let deleteAction: () -> Void

    var body: some View {
        VStack {
            if let soundName = userSound.soundName {
                Text(soundName)
                    .font(.title)
            }
            Text(userSound.fileName)
                .font(.subheadline)
            HStack {
                Button(action: playAction) {
                    Image(systemName: "play.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                }

               // Button(action: deleteAction) {
                 //   Image(systemName: "trash.circle.fill")
                   //     .font(.title)
                     //   .foregroundColor(.red)
                //}
            }
        }
    }
}

struct FavoriteViews_Previews: PreviewProvider {
    static var previews: some View {
        let sampleUserSounds: [UserSoud] = [
            UserSoud(fileName: "SampleSound1.mp3", soundName: "Sample1"),
            UserSoud(fileName: "SampleSound2.mp3", soundName: "Sample2")
        ]

        return FavoriteViews(userSounds: .constant(sampleUserSounds))
    }
}

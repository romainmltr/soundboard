//
//  FavoriteViews.swift
//  SoudboardQuizz
//
//  Created by Malaterre Romain on 21/11/2023.
//
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
                .navigationBarTitle("Add User Sound")

                List {
                    ForEach(userSounds) { userSound in
                        UserSoundCardView(userSound: userSound, playAction: {
                            playUserSound(userSound: userSound)
                        }, deleteAction: {
                            deleteUserSound(userSound: userSound)
                        })
                    }
                }
                .navigationBarTitle("User Sounds")
                .background(Color.clear)
            }
            .backgroundColorRadiant()
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
        }
    }
}

struct UserSoundCardView: View {
    let userSound: UserSoud
    let playAction: () -> Void
    let deleteAction: () -> Void

    var body: some View {
        
        VStack {
            
            Text(userSound.fileName)
            HStack {
                Button(action: playAction) {
                    Image(systemName: "play.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                }

                Button(action: deleteAction) {
                    Image(systemName: "trash.circle.fill")
                        .font(.title)
                        .foregroundColor(.red)
                }
           
                
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

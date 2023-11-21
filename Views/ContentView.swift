    import SwiftUI
    import AVFoundation

import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var sounds: [Sound] = Sound.allSounds()
    @State private var audioPlayer: AVAudioPlayer?
    @State private var showAlert = false
    @State private var soundToDelete: Sound?
    @State private var userSounds: [UserSoud] = []

    var body: some View {
        TabView {
            NavigationView {
                ScrollView {
                    ForEach(sounds) { sound in
                        CardView(sound: sound, playAction: {
                            playSound(sound: sound)
                        }, deleteAction: {
                            soundToDelete = sound
                            showAlert = true
                        })
                        .padding(.bottom, 10)
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Delete Sound"),
                        message: Text("Are you sure you want to delete this sound?"),
                        primaryButton: .destructive(Text("Delete")) {
                            if let sound = soundToDelete {
                                deleteSound(sound: sound)
                            }
                        },
                        secondaryButton: .cancel()
                    )
                }
                .navigationBarItems(trailing: VStack {
                    NavigationLink(destination: UserSoundFormView(userSounds: $userSounds)) {
                        Text("ajouter des sons")
                        Image(systemName: "person")
                    }
                })
            }
            .tabItem {
                Image(systemName: "play.circle.fill")
                Text("Sounds")
            }

            // Favorites Screen
            NavigationView {
                FavoriteViews(userSounds: userSounds)
            }
            .tabItem {
                Image(systemName: "heart.fill")
                Text("Favorites")
            }
        }
    }

    func playSound(sound: Sound) {
        if let soundURL = Bundle.main.url(forResource: sound.fileName, withExtension: nil) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }

    func deleteSound(sound: Sound) {
        if let index = sounds.firstIndex(where: { $0.id == sound.id }) {
            sounds.remove(at: index)
        }
    }
}



    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }


    
        
        
        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
        }
    }

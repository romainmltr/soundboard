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
            
            NavigationView {
                       JokeView()
                   }
                   .tabItem {
                       Image(systemName: "smiley.fill")
                       Text("Blague")
                   }
                   .tag(2)
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


    struct CardView: View {
        let sound: Sound
        let playAction: () -> Void
        let deleteAction: () -> Void

        var body: some View {
            VStack {
                if let imageURL = sound.imageURL {
                    AsyncImage(url: imageURL) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 100)
                        case .failure:
                            Image(systemName: "photo")
                        }
                    }
                } else {
                    Image(systemName: "photo")
                }

                Text(sound.name)
                    .padding()

                HStack {
                    Button(action: playAction) {
                        Image(systemName: "play.circle.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                    Spacer()
                    Button(action: deleteAction) {
                        Image(systemName: "trash.fill")
                            .font(.title)
                            .foregroundColor(.red)
                    }
                }
                .padding()
            }
            .background(Color.white)
            .cornerRadius(5)
            .shadow(radius: 1)
            .padding()
        }
    }
}

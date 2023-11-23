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
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach(sounds) { sound in
                            CardView(sound: sound, playAction: {
                                playSound(sound: sound)
                            }, deleteAction: {
                                soundToDelete = sound
                                showAlert = true
                            })
                            .frame(height: 240)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.0))
                    .navigationBarTitle("Sounds")
                    .navigationBarItems(trailing: VStack {
                        NavigationLink(destination: FavoriteViews(userSounds: $userSounds)) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.black)
                        }
                    })
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
            }
            .tabItem {
                Image(systemName: "play.circle.fill")
                Text("Sounds")
            }

            NavigationView {
                JokeView()
            }
            .tabItem {
                Image(systemName: "smiley.fill")
                Text("Blague")
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

    struct CardView: View {
        let sound: Sound
        let playAction: () -> Void
        let deleteAction: () -> Void

        @State private var isAnimating: Bool = false

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
                                .scaledToFit()
                                .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                                .scaleEffect(isAnimating ? 1.0 : 0.6)
                        case .failure:
                            Image(systemName: "photo")
                        }
                    }
                } else {
                    Image(systemName: "photo")
                }

                Text(sound.name)
                    .foregroundColor(Color.white)
                    .fontWeight(.heavy)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)

                HStack {
                    Button(action: playAction) {
                        Image(systemName: "play.circle.fill")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    .padding()

                    Button(action: deleteAction) {
                        Image(systemName: "trash.fill")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                    .padding()
                }
            }
            .padding()
            .onAppear {
                withAnimation(.easeOut(duration: 0.5)) {
                    isAnimating = true
                }
            }
            .frame(width: 160, height: 240)
            .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom))
            .cornerRadius(20)
            .shadow(radius: 10)
        }
    }
}

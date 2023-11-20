import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var sounds: [Sound] = Sound.allSounds()
    @State private var audioPlayer: AVAudioPlayer?

    var body: some View {
        NavigationView {
            List(sounds) { sound in
                Button(action: {
                    playSound(sound: sound)
                }) {
                    HStack(spacing: 20) {
                        if let imageURL = sound.imageURL {
                            AsyncImage(url: imageURL) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 200, height: 150)
                                case .failure:
                                    Image(systemName: "photo")
                                }
                            }
                        } else {
                            Image(systemName: "photo")
                        }
                        Text(sound.name)
                    }
                }
            }
            .navigationBarTitle("Soundboard")
            .navigationBarItems(
                leading: NavigationLink(destination: FormViews(sounds: $sounds)) {
                    Text("Ajouter")
                    Image(systemName: "music.note")
                }
            )
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

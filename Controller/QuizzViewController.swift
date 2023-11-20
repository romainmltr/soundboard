import UIKit
import AVFoundation

class QuizViewController: UIViewController {

    var audioPlayer: AVAudioPlayer?

    func playSound(sound: Sound) {
        if let soundURL = Bundle.main.url(forResource: sound.fileName, withExtension: nil) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch let error {
                print("Error playing sound: \(error.localizedDescription)")
            }
        }
    }

}


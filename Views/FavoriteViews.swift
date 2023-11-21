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
    var userSounds: [UserSoud]
    @State private var audioPlayer: AVAudioPlayer?

    var body: some View {
        List {
            ForEach(userSounds) { userSound in
                UserSoundCardView(userSound: userSound, playAction: {
                    playUserSound(userSound: userSound)
                })
            }
        }
        .navigationBarTitle("User Sounds")
    }

    func playUserSound(userSound: UserSoud) {
            
    }

}

struct UserSoundCardView: View {
    let userSound: UserSoud
    let playAction: () -> Void

    var body: some View {
        VStack {
            Text(userSound.fileName)
                .padding()

            HStack {
                Button(action: playAction) {
                    Image(systemName: "play.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                }
                Spacer()
            }
            .padding()
        }
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 1)
        .padding()
    }
}

struct FavoriteViews_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteViews(userSounds: UserSoud.userSounds())
    }
}

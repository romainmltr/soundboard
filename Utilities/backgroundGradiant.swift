//
//  backgroundGradiant.swift
//  SoudboardQuizz
//
//  Created by Malaterre Romain on 22/11/2023.
//

import Foundation
import SwiftUI

struct BackgroundColorRadiant: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(
                    colors: [
                        Color(hue: 211 / 360, saturation: 0.66, brightness: 0.87),
                        Color(hue: 348 / 360, saturation: 0.67, brightness: 0.88),
                        Color(hue: 272 / 360, saturation: 0.26, brightness: 0.72)
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
    }
}

extension View {
    func backgroundColorRadiant() -> some View {
        modifier(BackgroundColorRadiant())
    }
}

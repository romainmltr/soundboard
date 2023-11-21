import SwiftUI


class Sound: Identifiable {
    var id = UUID()
    var name: String
    var fileName: String
    var owner: String
    var imageURL: URL?

    init(name: String, fileName: String, owner: String, imageURL: String) {
        self.name = name
        self.fileName = fileName
        self.owner = owner
        self.imageURL = URL(string: imageURL)
    }

    static func allSounds() -> [Sound] {
        return [
            Sound(name: "Hein.mp3", fileName: "Hein.mp3", owner: "Zemmour", imageURL: "https://www.leparisien.fr/resizer/yaiZOJk5oE8Dt1lQzbShPXz_OKw=/932x582/cloudfront-eu-central-1.images.arcpublishing.com/leparisien/3NLPLLMGZ5ECNMEG5N6HWKLOK4.jpg"),
            Sound(name: "BenVoyons", fileName: "BenVoyons", owner: "BenVoyons", imageURL: "https://www.leparisien.fr/resizer/yaiZOJk5oE8Dt1lQzbShPXz_OKw=/932x582/cloudfront-eu-central-1.images.arcpublishing.com/leparisien/3NLPLLMGZ5ECNMEG5N6HWKLOK4.jpg"),
            Sound(name: "JlmAlertLesAmies.mp3", fileName: "JlmAlertLesAmies.mp3", owner: "JlmAlertLesAmies.mp3", imageURL: "https://www.leparisien.fr/resizer/oMII34qKJ2W8GoVZ0B2aWejf9Cg=/932x582/cloudfront-eu-central-1.images.arcpublishing.com/leparisien/FBJDUGQH5RG6BG22JVGHSZBRVM.jpg"),
            Sound(name:"tk78", fileName: "tk78", owner: "tk78", imageURL: "https://i.ytimg.com/vi/970_h2pxfo8/maxresdefault.jpg")
        ]
    }
}

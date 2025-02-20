import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    SoundManager.instance.playBackgroundMusic()
                    // FIXME: MAybe use it for when you lose
//                    SoundManager.instance.playLoop(forResource: "Flute", volume: 0.05)
                }
        }
    }
}

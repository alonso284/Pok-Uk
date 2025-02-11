//
//  File.swift
//  Pok'Uk
//
//  Created by Alonso Huerta on 29/01/25.
//

import AVKit
import AVFoundation

class SoundManager {
    
    static let instance = SoundManager()
    
    private var players: [String: AVAudioPlayer] = [:] // Store multiple players
    
    func playLoop(forResource resource: String, volume: Float, loop: Bool = false) {
        guard let musicURL = Bundle.main.url(forResource: resource, withExtension: "mp3") else {
            print("Sound file '\(resource).mp3' not found!")
            return
        }
        
        do {
            let player = try AVAudioPlayer(contentsOf: musicURL)
            player.numberOfLoops = (loop ? -1 : 0) // Infinite loop
            player.volume = volume // Adjust volume
            player.prepareToPlay()
            player.play()
            
            players[resource] = player // Store player in dictionary
            
        } catch {
            print("Error loading music \(resource): \(error.localizedDescription)")
        }
    }
    
    func stopSound(resource: String) {
        players[resource]?.stop()
        players.removeValue(forKey: resource)
    }
    
    func playBackgroundMusic() {
        playLoop(forResource: "Music", volume: 0.5) // Play music immediately
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.playLoop(forResource: "Ambient", volume: 0.3) // Delay ambient by 5 sec
        }
    }
    
}

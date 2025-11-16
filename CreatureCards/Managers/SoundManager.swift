//
//  SoundManager.swift
//  CreatureCards
//
//  Created by Владислав on 16.11.2025.
//
import AVFoundation

class SoundManager {
    static let shared = SoundManager()
    private var audioPlayer: AVAudioPlayer?
    
    private init() {}
    
    func playSound(named soundName: String) {
        // Сначала попробуем найти звук в бандле
        if let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            playSound(from: url)
        } else {
            print("Sound file not found: \(soundName)")
            // Временно используем системный звук
            playSystemSound()
        }
    }
    
    private func playSound(from url: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error)")
            playSystemSound()
        }
    }
    
    private func playSystemSound() {
        // Используем системный звук для тестирования
        AudioServicesPlaySystemSound(1103) // Звук "pop"
    }
    
    func stopSound() {
        audioPlayer?.stop()
    }
}

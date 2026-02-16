//
//  SoundManager.swift
//  CreatureCards
//
//  Created by Владислав on 16.02.2026.
//

import AVFoundation
import UIKit

class SoundManager: NSObject {
    
    // MARK: - Singleton
    static let shared = SoundManager()
    private override init() {
        super.init()
        setupAudioSession()
    }
    
    // MARK: - Properties
    private var audioPlayer: AVAudioPlayer?
    private var players: [String: AVAudioPlayer] = [:] // Для предзагрузки
    
    // MARK: - Setup
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("❌ Ошибка настройки аудиосессии: \(error)")
        }
    }
    
    // MARK: - Public Methods
    
    /// Предзагрузить все звуки (можно вызвать при запуске)
    func preloadAllSounds() {
        let soundFiles = [
            "cat_sound", "dog_sound", "lion_sound", "elephant_sound",
            "cow_sound", "snake_sound", "sheep_sound", "monkey_sound",
            "zebra_sound", "hippopotamus_sound"
        ]
        
        for soundFile in soundFiles {
            preloadSound(named: soundFile)
        }
        print("✅ Все звуки предзагружены")
    }
    
    /// Предзагрузить конкретный звук
    private func preloadSound(named soundName: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") ??
                       Bundle.main.url(forResource: soundName, withExtension: "m4a") else {
            print("⚠️ Звук не найден для предзагрузки: \(soundName)")
            return
        }
        
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            players[soundName] = player
            print("✅ Предзагружен: \(soundName)")
        } catch {
            print("❌ Ошибка предзагрузки \(soundName): \(error)")
        }
    }
    
    /// Воспроизвести звук
    func playSound(named soundName: String) {
        print("🔊 Попытка воспроизвести: \(soundName)")
        
        // Сначала проверяем, есть ли звук в предзагруженных
        if let player = players[soundName] {
            player.currentTime = 0
            player.play()
            print("✅ Воспроизвожу предзагруженный: \(soundName)")
            return
        }
        
        // Если нет, загружаем и играем
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") ??
                       Bundle.main.url(forResource: soundName, withExtension: "m4a") else {
            print("❌ Звук не найден: \(soundName)")
            playSystemSound() // Запасной вариант
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.delegate = self
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            print("✅ Играю: \(soundName)")
        } catch {
            print("❌ Ошибка воспроизведения \(soundName): \(error)")
            playSystemSound()
        }
    }
    
    /// Запасной системный звук
    private func playSystemSound() {
        print("🔔 Играю системный звук")
        AudioServicesPlaySystemSound(1103) // Звук "pop"
        
        // Показываем подсказку на экране
        DispatchQueue.main.async {
            self.showSoundNotFoundAlert()
        }
    }
    
    /// Показать предупреждение (опционально)
    private func showSoundNotFoundAlert() {
        guard let topVC = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        let alert = UIAlertController(
            title: "🎵 Звук пока не добавлен",
            message: "Скоро здесь будет настоящий звук животного!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        topVC.present(alert, animated: true)
    }
    
    /// Остановить все звуки
    func stopAllSounds() {
        audioPlayer?.stop()
        for (_, player) in players {
            player.stop()
        }
    }
}

// MARK: - AVAudioPlayerDelegate
extension SoundManager: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("✅ Звук закончил воспроизведение")
    }
}

//
//  Animals.swift
//  CreatureCards
//
//  Created by Владислав on 16.11.2025.
//
import UIKit

struct Animal {
    let id: String
    let name: String
    let russianName: String
    let letter: String
    let soundFileName: String
    let imageName: String
    let color: UIColor
    let funFact: String
    let animalImageName: String
}

// MARK: - Mock Data
class AnimalData {
    
    private static func a(_ id: String, _ name: String, _ russian: String,
                          _ letter: String, _ color: UIColor, fact: String = "") -> Animal {
        return Animal(
            id: id,
            name: name,
            russianName: russian,
            letter: letter,
            soundFileName: "\(id)_sound",
            imageName: "\(id)_icon",
            color: color,
            funFact: fact.isEmpty ? "✨ Узнай больше об этом животном!" : fact,
            animalImageName: "\(id)_image"
        )
    }
    
    static let animals: [Animal] = [
        a("cat", "Cat", "Кошка", "К", .systemOrange,
          fact: "Кошка может прыгнуть в 5 раз выше своего роста!"),
        
        a("dog", "Dog", "Собака", "С", .systemBrown,
          fact: "Собаки понимают до 250 слов и жестов!"),
        
        a("lion", "Lion", "Лев", "Л", .systemYellow,
          fact: "Лев может спать до 20 часов в день!"),
        
        a("elephant", "Elephant", "Слон", "С", .systemGray,
          fact: "Слоны могут слышать друг друга на расстоянии 8 км!"),
        
        a("cow", "Cow", "Корова", "К", .systemPurple,
          fact: "Коровы имеют почти 360-градусный обзор!"),
        
        a("snake", "Snake", "Змея", "З", .systemGreen),
        a("sheep", "Sheep", "Овечка", "О", .systemGray2),
        a("monkey", "Monkey", "Обезьяна", "О", .systemBrown),
        a("zebra", "Zebra", "Зебра", "З", .systemGray),
        a("hippopotamus", "Hippopotamus", "Бегемот", "Б", .systemIndigo)
    ]
    
    static func animal(at index: Int) -> Animal? {
        guard index >= 0 && index < animals.count else { return nil }
        return animals[index]
    }
    
    static var count: Int {
        return animals.count
    }
}

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
    static let animals: [Animal] = [
        Animal(
            id: "cat",
            name: "Cat",
            russianName: "Кошка",
            letter: "К",
            soundFileName: "cat_sound",
            imageName: "cat_icon",
            color: .systemOrange,
            funFact: "Кошка может прыгнуть в 5 раз выше своего роста!",
            animalImageName: "cat_image"
        ),
        Animal(
            id: "dog",
            name: "Dog",
            russianName: "Собака",
            letter: "С",
            soundFileName: "dog_sound",
            imageName: "dog_icon",
            color: .systemBrown,
            funFact: "Собаки понимают до 250 слов и жестов!",
            animalImageName: "dog_image"
        ),
        Animal(
            id: "lion",
            name: "Lion",
            russianName: "Лев",
            letter: "Л",
            soundFileName: "lion_sound",
            imageName: "lion_icon",
            color: .systemYellow,
            funFact: "Лев может спать до 20 часов в день!",
            animalImageName: "lion_image"
        ),
        Animal(
            id: "elephant",
            name: "Elephant",
            russianName: "Слон",
            letter: "С",
            soundFileName: "elephant_sound",
            imageName: "elephant_icon",
            color: .systemGray,
            funFact: "Слоны могут слышать друг друга на расстоянии 8 км!",
            animalImageName: "elephant_image"
        ),
        Animal(
            id: "cow",
            name: "Cow",
            russianName: "Корова",
            letter: "К",
            soundFileName: "cow_sound",
            imageName: "cow_icon",
            color: .systemPurple,
            funFact: "Коровы имеют почти 360-градусный обзор!",
            animalImageName: "cow_image"
        ),
        Animal(
            id: "snake",
            name: "Snake",
            russianName: "Змея",
            letter: "З",
            soundFileName: "snake_sound",
            imageName: "snake_icon",
            color: .systemGreen,
            funFact: "",
            animalImageName: "snake_image"
        ),
        Animal(
            id: "sheep",
            name: "Sheep",
            russianName: "Овечка",
            letter: "О",
            soundFileName: "sheep_sound",
            imageName: "sheep_icon",
            color: .systemGray2,
            funFact: "",
            animalImageName: "sheep_image"
        ),
        Animal(
            id: "monkey",
            name: "Monkey",
            russianName: "Обезьяна",
            letter: "О",
            soundFileName: "monkey_sound",
            imageName: "monkey_icon",
            color: .systemBrown,
            funFact: "",
            animalImageName: "monkey_image"
        ),
        Animal(
            id: "zebra",
            name: "Zebra",
            russianName: "Зебра",
            letter: "З",
            soundFileName: "zebra_sound",
            imageName: "zebra_icon",
            color: .systemGray,
            funFact: "",
            animalImageName: "zebra_image"
        ),
        Animal(
            id: "hippopotam",
            name: "Hippopotam",
            russianName: "Бегемот",
            letter: "Б",
            soundFileName: "mhippopotam_sound",
            imageName: "hippopotam_icon",
            color: .systemIndigo,
            funFact: "",
            animalImageName: "hippopotam_image"
        ),
    ]
    
    static func animal(at index: Int) -> Animal? {
        guard index >= 0 && index < animals.count else { return nil }
        return animals[index]
    }
    
    static var count: Int {
        return animals.count
    }
}

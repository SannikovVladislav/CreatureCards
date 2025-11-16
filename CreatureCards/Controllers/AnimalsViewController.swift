//
//  Animals.swift
//  CreatureCards
//
//  Created by Владислав on 06.11.2025.
//
import UIKit

class AnimalsViewController: UIViewController {
    
    // MARK: - UI Elements
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Карточки с животными"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.textColor = .systemIndigo
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let animalCard: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let animalLetterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 72)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let animalNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let englishNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white.withAlphaComponent(0.8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Следующее животное →", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemIndigo
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties
    private var currentAnimalIndex = 0
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupActions()
        showCurrentAnimal()
    }
    
    // MARK: - Setup
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(animalCard)
        animalCard.addSubview(animalLetterLabel)
        animalCard.addSubview(animalNameLabel)
        animalCard.addSubview(englishNameLabel)
        view.addSubview(nextButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // Animal Card
            animalCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animalCard.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            animalCard.widthAnchor.constraint(equalToConstant: 300),
            animalCard.heightAnchor.constraint(equalToConstant: 400),
            
            // Animal Letter
            animalLetterLabel.centerXAnchor.constraint(equalTo: animalCard.centerXAnchor),
            animalLetterLabel.topAnchor.constraint(equalTo: animalCard.topAnchor, constant: 30),
            
            // Animal Name (Russian)
            animalNameLabel.centerXAnchor.constraint(equalTo: animalCard.centerXAnchor),
            animalNameLabel.bottomAnchor.constraint(equalTo: englishNameLabel.topAnchor, constant: -8),
            
            // English Name
            englishNameLabel.centerXAnchor.constraint(equalTo: animalCard.centerXAnchor),
            englishNameLabel.bottomAnchor.constraint(equalTo: animalCard.bottomAnchor, constant: -30),
            
            // Next Button
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupActions() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCardTap))
        animalCard.addGestureRecognizer(tapGesture)
        
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Animal Display
    private func showCurrentAnimal() {
        guard let animal = AnimalData.animal(at: currentAnimalIndex) else { return }
        
        // Настраиваем карточку
        animalCard.backgroundColor = animal.color
        animalLetterLabel.text = animal.letter
        animalNameLabel.text = animal.russianName
        englishNameLabel.text = animal.name
        
        // Анимация появления
        animalCard.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        animalCard.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: []) {
            self.animalCard.transform = .identity
            self.animalCard.alpha = 1
        }
    }
    
    // MARK: - Actions
    @objc private func handleCardTap() {
        guard let animal = AnimalData.animal(at: currentAnimalIndex) else { return }
        
        // Воспроизводим звук
        SoundManager.shared.playSound(named: animal.soundFileName)
        
        // Анимация нажатия
        UIView.animate(withDuration: 0.1, animations: {
            self.animalCard.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.animalCard.transform = .identity
            }
        }
    }
    
    @objc private func nextButtonTapped() {
        // Переход к следующему животному
        currentAnimalIndex = (currentAnimalIndex + 1) % AnimalData.count
        showCurrentAnimal()
    }
}

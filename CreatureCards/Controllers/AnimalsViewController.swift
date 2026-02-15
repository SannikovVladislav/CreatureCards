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
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
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
        view.isUserInteractionEnabled = true
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
    
    private let animalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.3
        imageView.layer.shadowOffset = CGSize(width: 0, height: 1)
        imageView.layer.shadowRadius = 4
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        return imageView
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
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        
        // Делаем кнопку меньше и элегантнее
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        let backImage = UIImage(systemName: "chevron.left", withConfiguration: config)
        button.setImage(backImage, for: .normal)
        
        // Стиль как в навигационной панели
        button.tintColor = .systemIndigo
        button.backgroundColor = .clear
        button.layer.cornerRadius = 15
        button.layer.shadowOpacity = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавляем текст справа от иконки
        var configButton = UIButton.Configuration.plain()
        configButton.image = backImage
        configButton.title = "Назад"
        configButton.imagePadding = 8
        configButton.baseForegroundColor = .systemIndigo
        button.configuration = configButton
        
        return button
    }()
    
    // MARK: - Properties
    private var currentAnimalIndex = 0
    private var panGestureRecognizer: UIPanGestureRecognizer!
    private var shuffledAnimals: [Animal] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Отключаем системный жест навигации
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        // Убираем кнопку назад, добавим свою позже если нужно
        navigationItem.setHidesBackButton(true, animated: false)
        
        print("🔍 Статус системного жеста: \(navigationController?.interactivePopGestureRecognizer?.isEnabled == true ? "ВКЛ" : "ВЫКЛ")")
        
        shuffledAnimals = AnimalData.animals.shuffled()
        
        setupView()
        setupConstraints()
        setupActions()
        setupGestures()
        showCurrentAnimal()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Дополнительная проверка при появлении экрана
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    // MARK: - Setup
    private func setupView() {
        view.backgroundColor = .lightGreen
        view.addSubview(titleLabel)
        view.addSubview(animalCard)
        view.addSubview(backButton)
        animalCard.addSubview(animalLetterLabel)
        animalCard.addSubview(animalImageView)
        animalCard.addSubview(animalNameLabel)
        animalCard.addSubview(englishNameLabel)
        view.addSubview(nextButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Back Button - теперь слева сверху
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Title Label - по центру
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),
            
            // Animal Card - немного смещаем вверх
            animalCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animalCard.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            animalCard.widthAnchor.constraint(equalToConstant: 300),
            animalCard.heightAnchor.constraint(equalToConstant: 400),
            
            // Animal Letter
            animalLetterLabel.centerXAnchor.constraint(equalTo: animalCard.centerXAnchor),
            animalLetterLabel.topAnchor.constraint(equalTo: animalCard.topAnchor, constant: 30),
            
            // Animal Image
            animalImageView.centerXAnchor.constraint(equalTo: animalCard.centerXAnchor),
            animalImageView.centerYAnchor.constraint(equalTo: animalCard.centerYAnchor),
            animalImageView.widthAnchor.constraint(equalToConstant: 190),
            animalImageView.heightAnchor.constraint(equalToConstant: 190),
            
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
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCardTap))
        animalCard.addGestureRecognizer(tapGesture)
    }

    
    private func setupGestures() {
        // Используем PanGestureRecognizer для максимального контроля
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        panGestureRecognizer.delegate = self
        animalCard.addGestureRecognizer(panGestureRecognizer)
        
        // Тап для звука
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCardTap))
        animalCard.addGestureRecognizer(tapGesture)
    }
    
    // MARK: - Pan Gesture Handling
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        switch gesture.state {
        case .began:
            print("▶️ Начало свайпа")
            
        case .changed:
            // Двигаем карточку за пальцем (только по горизонтали)
            if abs(translation.x) > abs(translation.y) {
                animalCard.transform = CGAffineTransform(translationX: translation.x, y: 0)
                // Немного уменьшаем прозрачность
                let alpha = 1 - min(abs(translation.x) / 300, 0.3)
                animalCard.alpha = alpha
            }
            
        case .ended, .cancelled:
            print("⏹️ Конец свайпа, translation: \(translation.x)")
            
            // Определяем, был ли это достаточный свайп
            let shouldChangePage = abs(translation.x) > 100 || abs(velocity.x) > 500
            
            if shouldChangePage {
                // Определяем направление
                if translation.x < 0 { // Свайп влево - следующее животное
                    print("➡️ Следующее животное")
                    currentAnimalIndex = (currentAnimalIndex + 1) % shuffledAnimals.count
                } else { // Свайп вправо - предыдущее животное
                    print("⬅️ Предыдущее животное")
                    currentAnimalIndex = (currentAnimalIndex - 1 + shuffledAnimals.count) % shuffledAnimals.count
                }
                
                // Анимация ухода карточки
                let direction = translation.x < 0 ? -1.0 : 1.0
                UIView.animate(withDuration: 0.2, animations: {
                    self.animalCard.transform = CGAffineTransform(translationX: direction * 300, y: 0)
                    self.animalCard.alpha = 0
                }) { _ in
                    self.showCurrentAnimal()
                    UIView.animate(withDuration: 0.2) {
                        self.animalCard.transform = .identity
                        self.animalCard.alpha = 1
                    }
                }
            }
            
        default:
            break
        }
    }
    
    // MARK: - Animal Display
    private func showCurrentAnimal() {
        guard currentAnimalIndex < shuffledAnimals.count else { return }
        let animal = shuffledAnimals[currentAnimalIndex]
        
        // Настраиваем карточку
        animalCard.backgroundColor = animal.color
        animalLetterLabel.text = animal.letter
        animalNameLabel.text = animal.russianName
        englishNameLabel.text = animal.name
        
        // Загрузка изображения животного
        if let image = UIImage(named: animal.animalImageName) {
            animalImageView.image = image
        } else {
            animalImageView.image = UIImage(systemName: "photo")?
                .withTintColor(.white, renderingMode: .alwaysOriginal)
            print("Image not found: \(animal.animalImageName)")
        }
        
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
        currentAnimalIndex = (currentAnimalIndex + 1) % shuffledAnimals.count
        showCurrentAnimal()
    }
    
    @objc private func backButtonTapped() {
        print("⬅️ Возврат на главный экран")
        
        // Анимация нажатия
        UIView.animate(withDuration: 0.1, animations: {
            self.backButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.backButton.transform = .identity
            }
        }
        
        // Возвращаемся
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UIGestureRecognizerDelegate
extension AnimalsViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // Блокируем системный жест назад
        if gestureRecognizer == navigationController?.interactivePopGestureRecognizer {
            print("🚫 Блокируем системный свайп назад")
            return false
        }
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // Наш pan жест не должен конфликтовать с другими
        if gestureRecognizer == panGestureRecognizer {
            return false
        }
        return true
    }
}

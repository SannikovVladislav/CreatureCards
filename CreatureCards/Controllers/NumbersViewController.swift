//
//  NumbersViewController.swift
//  CreatureCards
//
//  Created by Владислав on 03.06.2026.
//
import UIKit

struct Number {
    let value: Int
    let word: String
    let wordEng: String
    let color: UIColor
    let imageName: String
    let fact: String
}

class NumbersViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Учим цифры"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        label.textColor = .lightFiolet
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberCard: UIView = {
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
    
    private let numberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 240)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let wordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let wordEngLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white.withAlphaComponent(0.8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let factLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textAlignment = .center
        label.textColor = .white.withAlphaComponent(0.9)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Следующая цифра →", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = .lightFiolet
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 20, weight: .semibold)
        let backImage = UIImage(systemName: "chevron.left", withConfiguration: config)
        button.setImage(backImage, for: .normal)
        button.tintColor = .systemIndigo
        button.backgroundColor = .clear
        button.layer.cornerRadius = 15
        button.layer.shadowOpacity = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        
        var configButton = UIButton.Configuration.plain()
        configButton.image = backImage
        configButton.title = "Назад"
        configButton.imagePadding = 8
        configButton.baseForegroundColor = .systemIndigo
        button.configuration = configButton
        
        return button
    }()
    
    // MARK: - Properties
    
    private var numbers: [Number] = []
    private var currentIndex = 0
    private var panGestureRecognizer: UIPanGestureRecognizer!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        loadNumbers()
        setupView()
        setupConstraints()
        setupActions()
        setupGestures()
        showCurrentNumber()
    }
    
    // MARK: - Setup
    
    private func setupNavigation() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    private func loadNumbers() {
        numbers = [
            Number(value: 1, word: "Один", wordEng: "One", color: .systemRed,
                   imageName: "one_image", fact: "У тебя один носик!"),
            Number(value: 2, word: "Два", wordEng: "Two", color: .systemOrange,
                   imageName: "two_image", fact: "У тебя два глаза!"),
            Number(value: 3, word: "Три", wordEng: "Three", color: .systemYellow,
                   imageName: "three_image", fact: "У светофора три цвета!"),
            Number(value: 4, word: "Четыре", wordEng: "Four", color: .systemGreen,
                   imageName: "four_image", fact: "У машины четыре колеса!"),
            Number(value: 5, word: "Пять", wordEng: "Five", color: .systemBlue,
                   imageName: "five_image", fact: "На руке пять пальчиков!"),
            Number(value: 6, word: "Шесть", wordEng: "Six", color: .systemPurple,
                   imageName: "six_image", fact: "У насекомых шесть ног!"),
            Number(value: 7, word: "Семь", wordEng: "Seven", color: .systemPink,
                   imageName: "seven_image", fact: "В радуге семь цветов!"),
            Number(value: 8, word: "Восемь", wordEng: "Eight", color: .systemBrown,
                   imageName: "eight_image", fact: "У осьминога восемь щупалец!"),
            Number(value: 9, word: "Девять", wordEng: "Nine", color: .systemTeal,
                   imageName: "nine_image", fact: "У кошки девять жизней!"),
            Number(value: 10, word: "Десять", wordEng: "Ten", color: .systemIndigo,
                   imageName: "ten_image", fact: "У тебя десять пальчиков на руках!")
        ]
    }
    
    private func setupView() {
        view.backgroundColor = .lightGreen
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(numberCard)
        numberCard.addSubview(numberLabel)
        numberCard.addSubview(wordLabel)
        numberCard.addSubview(wordEngLabel)
        numberCard.addSubview(factLabel)
        view.addSubview(nextButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Back Button
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Number Card
            numberCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numberCard.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            numberCard.widthAnchor.constraint(equalToConstant: 320),
            numberCard.heightAnchor.constraint(equalToConstant: 480),
            
            // Number Label (большая цифра)
            numberLabel.centerXAnchor.constraint(equalTo: numberCard.centerXAnchor),
            numberLabel.topAnchor.constraint(equalTo: numberCard.topAnchor, constant: 50),
            
            // Word Label (на русском)
            wordLabel.centerXAnchor.constraint(equalTo: numberCard.centerXAnchor),
            wordLabel.bottomAnchor.constraint(equalTo: wordEngLabel.topAnchor, constant: -8),
            
            // English Word Label
            wordEngLabel.centerXAnchor.constraint(equalTo: numberCard.centerXAnchor),
            wordEngLabel.bottomAnchor.constraint(equalTo: factLabel.topAnchor, constant: -12),
            
            // Fact Label
            factLabel.centerXAnchor.constraint(equalTo: numberCard.centerXAnchor),
            factLabel.leadingAnchor.constraint(equalTo: numberCard.leadingAnchor, constant: 16),
            factLabel.trailingAnchor.constraint(equalTo: numberCard.trailingAnchor, constant: -16),
            factLabel.bottomAnchor.constraint(equalTo: numberCard.bottomAnchor, constant: -20),
            
            // Next Button
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        numberCard.addGestureRecognizer(tapGesture)
    }
    
    private func setupGestures() {
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        panGestureRecognizer.delegate = self
        numberCard.addGestureRecognizer(panGestureRecognizer)
    }
    
    // MARK: - Display
    
    private func showCurrentNumber() {
        guard currentIndex < numbers.count else {
            currentIndex = 0
            return
        }
        let number = numbers[currentIndex]
        
        numberCard.backgroundColor = number.color
        numberLabel.text = "\(number.value)"
        wordLabel.text = number.word
        wordEngLabel.text = number.wordEng
        factLabel.text = number.fact
        
        // Анимация появления
        animateCardAppearance()
    }
    
    private func createNumberImage(_ number: Int) -> UIImage {
        // Создаем простую картинку с цифрой на случай, если нет изображения
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 150, height: 150))
        return renderer.image { context in
            UIColor.white.setFill()
            context.fill(CGRect(x: 0, y: 0, width: 150, height: 150))
            
            let text = "\(number)" as NSString
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 80),
                .foregroundColor: UIColor.lightFiolet
            ]
            text.draw(at: CGPoint(x: 40, y: 35), withAttributes: attributes)
        }
    }
    
    private func animateCardAppearance() {
        numberCard.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        numberCard.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.5, options: []) {
            self.numberCard.transform = .identity
            self.numberCard.alpha = 1
        }
    }
    
    // MARK: - Gestures
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        switch gesture.state {
        case .changed:
            if abs(translation.x) > abs(translation.y) {
                numberCard.transform = CGAffineTransform(translationX: translation.x, y: 0)
                let alpha = 1 - min(abs(translation.x) / 300, 0.3)
                numberCard.alpha = alpha
            }
            
        case .ended:
            let shouldChange = abs(translation.x) > 100 || abs(velocity.x) > 500
            
            if shouldChange {
                let direction = translation.x < 0 ? -1.0 : 1.0
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.numberCard.transform = CGAffineTransform(translationX: direction * 300, y: 0)
                    self.numberCard.alpha = 0
                }) { _ in
                    if translation.x < 0 { // Влево — следующая цифра
                        self.currentIndex = (self.currentIndex + 1) % self.numbers.count
                    } else { // Вправо — предыдущая цифра
                        self.currentIndex = (self.currentIndex - 1 + self.numbers.count) % self.numbers.count
                    }
                    self.showCurrentNumber()
                    UIView.animate(withDuration: 0.2) {
                        self.numberCard.transform = .identity
                        self.numberCard.alpha = 1
                    }
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.numberCard.transform = .identity
                    self.numberCard.alpha = 1
                }
            }
            
        default:
            break
        }
    }
    
    @objc private func handleTap() {
        let number = numbers[currentIndex]
        
        // Воспроизводим звук (пока системный)
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        // Анимация нажатия
        UIView.animate(withDuration: 0.1, animations: {
            self.numberCard.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.numberCard.transform = .identity
            }
        }
        
        // Показываем всплывашку с цифрой
        showNumberPopup(number.value)
    }
    
    private func showNumberPopup(_ number: Int) {
        let popup = UILabel()
        popup.text = "\(number)"
        popup.font = UIFont.boldSystemFont(ofSize: 100)
        popup.textColor = .lightFiolet
        popup.textAlignment = .center
        popup.alpha = 0
        popup.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(popup)
        popup.centerXAnchor.constraint(equalTo: numberCard.centerXAnchor).isActive = true
        popup.centerYAnchor.constraint(equalTo: numberCard.centerYAnchor).isActive = true
        
        UIView.animate(withDuration: 0.3, animations: {
            popup.alpha = 1
            popup.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) { _ in
            UIView.animate(withDuration: 0.3, animations: {
                popup.alpha = 0
            }) { _ in
                popup.removeFromSuperview()
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func nextTapped() {
        currentIndex = (currentIndex + 1) % numbers.count
            showCurrentNumber()
        }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Gesture Delegate
extension NumbersViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == navigationController?.interactivePopGestureRecognizer {
            return false
        }
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer == panGestureRecognizer {
            return false
        }
        return true
    }
}

#Preview {
    NumbersViewController()
}

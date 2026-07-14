//
//  AlphabetViewController.swift
//  CreatureCards
//
//  Created by Владислав on 14.07.2026.
//
import UIKit

class AlphabetViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Русский алфавит"
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        label.textColor = .lightFiolet
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let letterCard: UIView = {
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

    private let letterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 200)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("← Предыдущая", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = .lightFiolet
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Следующая →", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = .lightFiolet
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "chevron.left")
        config.title = "Назад в меню"
        config.imagePadding = 8
        config.baseForegroundColor = .lightFiolet
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties
    
    private var currentIndex = 0
    private var panGestureRecognizer: UIPanGestureRecognizer!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigation()
        setupView()
        setupConstraints()
        setupActions()
        setupGestures()
        showCurrentLetter()
    }
    
    // MARK: - Setup
    
    private func setupNavigation() {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationItem.setHidesBackButton(true, animated: false)
    }
    
    private func setupView() {
        view.backgroundColor = .lightGreen
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(letterCard)
        letterCard.addSubview(letterLabel)
        view.addSubview(previousButton)
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
            
            // Letter Card
            letterCard.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            letterCard.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
            letterCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            letterCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            letterCard.heightAnchor.constraint(equalTo: letterCard.widthAnchor, multiplier: 1.2),
            
            // Big Letter - на всю карточку
            letterLabel.centerXAnchor.constraint(equalTo: letterCard.centerXAnchor),
            letterLabel.centerYAnchor.constraint(equalTo: letterCard.centerYAnchor),
            
            // Previous Button
            previousButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            previousButton.topAnchor.constraint(equalTo: letterCard.bottomAnchor, constant: 30),
            previousButton.heightAnchor.constraint(equalToConstant: 60),
            previousButton.widthAnchor.constraint(equalToConstant: 160),
            
            // Next Button
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            nextButton.topAnchor.constraint(equalTo: letterCard.bottomAnchor, constant: 30),
            nextButton.heightAnchor.constraint(equalToConstant: 60),
            nextButton.widthAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func setupActions() {
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        previousButton.addTarget(self, action: #selector(previousTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        letterCard.addGestureRecognizer(tapGesture)
    }
    
    private func setupGestures() {
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        panGestureRecognizer.delegate = self
        letterCard.addGestureRecognizer(panGestureRecognizer)
    }
    
    // MARK: - Display
    
    private func showCurrentLetter() {
        guard let letter = AlphabetData.letter(at: currentIndex) else {
            currentIndex = 0
            return
        }
        
        letterCard.backgroundColor = letter.color
        letterLabel.text = letter.letter
        
        animateCardAppearance()
    }
    
    private func animateCardAppearance() {
        letterCard.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        letterCard.alpha = 0
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6,
                      initialSpringVelocity: 0.5, options: []) {
            self.letterCard.transform = .identity
            self.letterCard.alpha = 1
        }
    }
    
    // MARK: - Gestures
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        switch gesture.state {
        case .changed:
            if abs(translation.x) > abs(translation.y) {
                letterCard.transform = CGAffineTransform(translationX: translation.x, y: 0)
                let alpha = 1 - min(abs(translation.x) / 300, 0.3)
                letterCard.alpha = alpha
            }
            
        case .ended:
            let shouldChange = abs(translation.x) > 100 || abs(velocity.x) > 500
            
            if shouldChange {
                let direction = translation.x < 0 ? -1.0 : 1.0
                
                UIView.animate(withDuration: 0.2, animations: {
                    self.letterCard.transform = CGAffineTransform(translationX: direction * 300, y: 0)
                    self.letterCard.alpha = 0
                }) { _ in
                    if translation.x < 0 {
                        self.currentIndex = (self.currentIndex + 1) % AlphabetData.count
                    } else {
                        self.currentIndex = (self.currentIndex - 1 + AlphabetData.count) % AlphabetData.count
                    }
                    self.showCurrentLetter()
                    UIView.animate(withDuration: 0.2) {
                        self.letterCard.transform = .identity
                        self.letterCard.alpha = 1
                    }
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.letterCard.transform = .identity
                    self.letterCard.alpha = 1
                }
            }
            
        default:
            break
        }
    }
    
    @objc private func handleTap() {
        guard let letter = AlphabetData.letter(at: currentIndex) else { return }
        
        // Воспроизводим звук (пока системный)
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        // Анимация нажатия
        UIView.animate(withDuration: 0.1, animations: {
            self.letterCard.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            UIView.animate(withDuration: 0.1) {
                self.letterCard.transform = .identity
            }
        }
        
        showLetterPopup(letter.letter)
    }
    
    private func showLetterPopup(_ letter: String) {
        let popup = UILabel()
        popup.text = letter
        popup.font = UIFont.boldSystemFont(ofSize: 150)
        popup.textColor = .lightFiolet
        popup.textAlignment = .center
        popup.alpha = 0
        popup.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(popup)
        popup.centerXAnchor.constraint(equalTo: letterCard.centerXAnchor).isActive = true
        popup.centerYAnchor.constraint(equalTo: letterCard.centerYAnchor).isActive = true
        
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
        currentIndex = (currentIndex + 1) % AlphabetData.count
        showCurrentLetter()
    }
    
    @objc private func previousTapped() {
        currentIndex = (currentIndex - 1 + AlphabetData.count) % AlphabetData.count
        showCurrentLetter()
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Gesture Delegate
extension AlphabetViewController: UIGestureRecognizerDelegate {
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

// MARK: - Preview
#Preview {
    AlphabetViewController()
}

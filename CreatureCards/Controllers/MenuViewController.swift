//
//  MenuViewController.swift
//  CreatureCards
//
//  Created by Владислав on 03.06.2026.
//
import UIKit

class MenuViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Выбери тему"
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.textAlignment = .center
        label.textColor = .lightFiolet
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let animalsButton: UIButton = {
        let button = UIButton(type: .system)
        
        // Настраиваем кнопку с иконкой
        var config = UIButton.Configuration.filled()
        config.title = "Животные"
        config.subtitle = "Изучай буквы и звуки"
        config.image = UIImage(systemName: "hare.fill")
        config.imagePadding = 12
        config.imagePlacement = .top
        config.baseBackgroundColor = .lightOrange
        config.baseForegroundColor = .white
        config.cornerStyle = .large
        
        button.configuration = config
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let numbersButton: UIButton = {
        let button = UIButton(type: .system)
        
        var config = UIButton.Configuration.filled()
        config.title = "Цифры"
        config.subtitle = "Учимся считать от 1 до 10"
        config.image = UIImage(systemName: "123.rectangle.fill")
        config.imagePadding = 12
        config.imagePlacement = .top
        config.baseBackgroundColor = .systemPurple
        config.baseForegroundColor = .white
        config.cornerStyle = .large
        
        button.configuration = config
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("← Назад", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.setTitleColor(.lightFiolet, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupActions()
    }
    
    // MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .lightGreen
        view.addSubview(titleLabel)
        view.addSubview(animalsButton)
        view.addSubview(numbersButton)
        view.addSubview(backButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Back Button
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // Title Label
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Animals Button
            animalsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animalsButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -60),
            animalsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            animalsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            animalsButton.heightAnchor.constraint(equalToConstant: 120),
            
            // Numbers Button
            numbersButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            numbersButton.topAnchor.constraint(equalTo: animalsButton.bottomAnchor, constant: 30),
            numbersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            numbersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            numbersButton.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
    
    private func setupActions() {
        animalsButton.addTarget(self, action: #selector(animalsTapped), for: .touchUpInside)
        numbersButton.addTarget(self, action: #selector(numbersTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @objc private func animalsTapped() {
        let animalsVC = AnimalsViewController()
        navigationController?.pushViewController(animalsVC, animated: true)
    }
    
    @objc private func numbersTapped() {
        let numbersVC = AnimalsViewController()
        navigationController?.pushViewController(numbersVC, animated: true)
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
}

//
//  ViewController.swift
//  CreatureCards
//
//  Created by Владислав on 06.11.2025.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - UI  Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Creature Cards"
        label.font = UIFont.systemFont(ofSize: 36)
        label.textAlignment = .center
        label.textColor = .lightFiolet
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Для маленькой Альбины"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Начать", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.backgroundColor = .lightFiolet
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let animalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "hare.fill")?
            .withTintColor(.lightOrange, renderingMode: .alwaysOriginal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setupAction()
    }
    
    //MARK: - Setup
    
    private func setupView() {
        view.backgroundColor = .lightGreen
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(animalImageView)
        view.addSubview(startButton)
    }
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            //Title Label
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            //Subtitle Label
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            subTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            //Animal Image
            animalImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animalImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animalImageView.widthAnchor.constraint(equalToConstant: 200),
            animalImageView.heightAnchor.constraint(equalToConstant: 200),
            
            //Start Button
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            startButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            startButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            startButton.heightAnchor.constraint(equalToConstant: 80)
            ])
    }
    
    private func setupAction() {
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc private func startButtonTapped() {
        let animalsVC = AnimalsViewController()
        navigationController?.pushViewController(animalsVC, animated: true)
    }
}

#Preview {MainViewController()}

//
//  Animals.swift
//  CreatureCards
//
//  Created by Владислав on 06.11.2025.
//
import UIKit

class AnimalsViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Животные"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.textColor = .systemIndigo
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
}

//
//  AlphabetData.swift
//  CreatureCards
//
//  Created by Владислав on 14.07.2026.
//
import UIKit

struct Letter {
    let letter: String
    let soundFileName: String
    let color: UIColor
}

class AlphabetData {
    static let letters: [Letter] = [
        Letter(letter: "А", soundFileName: "a_sound", color: .systemRed),
        Letter(letter: "Б", soundFileName: "b_sound", color: .systemOrange),
        Letter(letter: "В", soundFileName: "v_sound", color: .systemYellow),
        Letter(letter: "Г", soundFileName: "g_sound", color: .systemGreen),
        Letter(letter: "Д", soundFileName: "d_sound", color: .systemBlue),
        Letter(letter: "Е", soundFileName: "e_sound", color: .systemPurple),
        Letter(letter: "Ё", soundFileName: "yo_sound", color: .systemPink),
        Letter(letter: "Ж", soundFileName: "zh_sound", color: .systemBrown),
        Letter(letter: "З", soundFileName: "z_sound", color: .systemTeal),
        Letter(letter: "И", soundFileName: "i_sound", color: .systemIndigo),
        Letter(letter: "Й", soundFileName: "y_sound", color: .systemMint),
        Letter(letter: "К", soundFileName: "k_sound", color: .systemRed),
        Letter(letter: "Л", soundFileName: "l_sound", color: .systemOrange),
        Letter(letter: "М", soundFileName: "m_sound", color: .systemYellow),
        Letter(letter: "Н", soundFileName: "n_sound", color: .systemGreen),
        Letter(letter: "О", soundFileName: "o_sound", color: .systemBlue),
        Letter(letter: "П", soundFileName: "p_sound", color: .systemPurple),
        Letter(letter: "Р", soundFileName: "r_sound", color: .systemPink),
        Letter(letter: "С", soundFileName: "s_sound", color: .systemBrown),
        Letter(letter: "Т", soundFileName: "t_sound", color: .systemTeal),
        Letter(letter: "У", soundFileName: "u_sound", color: .systemIndigo),
        Letter(letter: "Ф", soundFileName: "f_sound", color: .systemMint),
        Letter(letter: "Х", soundFileName: "h_sound", color: .systemRed),
        Letter(letter: "Ц", soundFileName: "ts_sound", color: .systemOrange),
        Letter(letter: "Ч", soundFileName: "ch_sound", color: .systemYellow),
        Letter(letter: "Ш", soundFileName: "sh_sound", color: .systemGreen),
        Letter(letter: "Щ", soundFileName: "shch_sound", color: .systemBlue),
        Letter(letter: "Ы", soundFileName: "y_sound", color: .systemPurple),
        Letter(letter: "Ь", soundFileName: "soft_sign_sound", color: .systemPink),
        Letter(letter: "Э", soundFileName: "e_sound", color: .systemBrown),
        Letter(letter: "Ю", soundFileName: "yu_sound", color: .systemTeal),
        Letter(letter: "Я", soundFileName: "ya_sound", color: .systemIndigo)
    ]
    
    static var count: Int {
        return letters.count
    }
    
    static func letter(at index: Int) -> Letter? {
        guard index >= 0 && index < letters.count else { return nil }
        return letters[index]
    }
}

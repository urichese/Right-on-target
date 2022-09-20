//
//  ViewController.swift
//  Right on target
//
//  Created by urichese on 05.07.2022.
//

import UIKit

class ViewController: UIViewController {

    var game: Game!
    @IBOutlet var slider: UISlider!
    @IBOutlet var label: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    // MARK: - Жизненный цикл viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // генерируем случайное число
        // Создаем экземпляр сущности "Игра"
        game = Game(startValue: 0, endValue: 100, rounds: 5)
        // Обновляем данные о текущем значении загаданного числа
        updateLabelWithSecretNumber(newText: String(game.currentSecretValue))
        updateResultLabel(newText: "")
    }
    // MARK: - Обновление View
    // Обновление текста загаданного числа
    private func updateLabelWithSecretNumber(newText: String ) {
       label.text = newText
    }
    // Обновление текста результата
    private func updateResultLabel(newText: String ) {
        resultLabel.text = newText
    }
    // MARK: - Взаимодействие View - Model
    // Проверка выбранного пользователем числа
    @IBAction func checkNumber() {
    // Высчитываем очки за раунд
        updateResultLabel(newText: String(Int(slider.value * 100)))
        game.calculateScore(with: Int(slider.value * 100))
        // Проверяем, окончена ли игра
        if game.isGameEnded {
            showAlertWith(score: game.score) // Начинаем игру заново
            game.restartGame()
        } else {
            game.startNewRound()
    }
    // Обновляем данные о текущем значении загаданного числа
        updateLabelWithSecretNumber(newText: String(game.currentSecretValue))
    }
    // Отображение всплывающего окна со счетом
    private func showAlertWith(score: Int) {
        let alert = UIAlertController(
        title: "Игра окончена",
        message: "Вы заработали \(score) очков", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Начать заново", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//
//  ViewController.swift
//  Project Hangman
//
//  Created by Taimoor Mujahid on 2023-06-12.
//

import UIKit

class ViewController: UIViewController {

    var wordCount: Int = 1
    let words = ["improve", "foreign", "smoking", "helping", "medical", "jointly", "auction", "journal", "himself", "kingdom", "parking", "organic", "serving"]
    var correctChoices: [Int] = []
    var guessedWord: String = ""
    var lostCount: Int = 0
    var winCount: Int = 0
    
    @IBOutlet var keyboardKeysCollection: [UIButton]!
    @IBOutlet weak var labelLossCount: UILabel!
    @IBOutlet weak var labelWinCount: UILabel!
    @IBOutlet weak var imageHead: UIImageView!
    @IBOutlet weak var imageSmile: UIImageView!
    @IBOutlet weak var imageLeftLeg: UIImageView!
    @IBOutlet weak var imageSad: UIImageView!
    @IBOutlet weak var imageRightLeg: UIImageView!
    @IBOutlet weak var imageLeftARM: UIImageView!
    @IBOutlet weak var imageRightArm: UIImageView!
    @IBOutlet weak var imageBody: UIImageView!
    @IBOutlet var buttonCollection: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.guessedWord = self.words.randomElement() ?? ""
        print(self.guessedWord)
        self.setupImagesInitially()
    }
    
    fileprivate func setupImagesInitially() {
        self.imageSad.isHidden = true
        self.imageRightArm.isHidden = true
        self.imageBody.isHidden = true
        self.imageLeftARM.isHidden = true
        self.imageRightLeg.isHidden = true
        self.imageHead.isHidden = true
        self.imageSmile.isHidden = true
        self.imageLeftLeg.isHidden = true
    }
    
    fileprivate func showAlert(status: Bool) {
        let alert = UIAlertController(title: status == true ? AppConstants.successAlertTitle : AppConstants.failureAlertTitle, message: status == true ?  AppConstants.successAlertMessage : AppConstants.failureAlertMessage + self.guessedWord + AppConstants.playAgainMessage, preferredStyle: .alert)
        let actionYes = UIAlertAction(title: "Yes", style: .default) {_ in
            self.setupImagesInitially()
            self.guessedWord = self.words.randomElement() ?? ""
            print(self.guessedWord)
            self.wordCount = 1
            self.correctChoices.removeAll()
            for button in self.buttonCollection {
                button.setTitle("_", for: .normal)
            }
            
            for keyboardKey in self.keyboardKeysCollection {
                keyboardKey.tintColor = UIColor.tintColor
            }
            alert.dismiss(animated: true)
        }
        
        let actionNo = UIAlertAction(title: "No", style: .destructive) {_ in
            alert.dismiss(animated: true)
        }
        
        alert.addAction(actionYes)
        alert.addAction(actionNo)
        self.present(alert, animated: true)
    }


    @IBAction func didTapKeyboard(_ sender: UIButton) {
        guard let selectedKey = sender.titleLabel?.text?.lowercased() else {
            return
        }
        
    
        if self.guessedWord.contains(selectedKey) {
            sender.tintColor = UIColor.green
            self.settingTitlesForCorrectSelections(selectedKey: selectedKey)
            if self.correctChoices.count == 7 {
                self.winCount += 1
                self.labelWinCount.text = "\(self.winCount)"
                self.imageSmile.isHidden = false
                self.showAlert(status: true)
            }
        } else {
            sender.tintColor = UIColor.red
            self.configureImageViewsOnUserResponse()
        }
    }
    
    fileprivate func settingTitlesForCorrectSelections(selectedKey: String) {
        if let range: Range<String.Index> = self.guessedWord.range(of: selectedKey) {
            let index: Int = self.guessedWord.distance(from: self.guessedWord.startIndex, to: range.lowerBound)
            self.buttonCollection[index].setTitle(selectedKey.uppercased(), for: .normal)
            self.correctChoices.append(1)
        }
    }
    
    fileprivate func configureImageViewsOnUserResponse() {
        switch self.wordCount {
        case 1:
            self.wordCount += 1
            self.imageHead.isHidden = false
        case 2:
            self.wordCount += 1
            self.imageBody.isHidden = false
        case 3:
            self.wordCount += 1
            self.imageLeftARM.isHidden = false
        case 4:
            self.wordCount += 1
            self.imageRightArm.isHidden = false
        case 5:
            self.wordCount += 1
            self.imageLeftLeg.isHidden = false
        case 6:
            self.wordCount += 1
            self.imageRightLeg.isHidden = false
        case 7:
            self.wordCount += 1
            self.imageSad.isHidden = false
            self.lostCount += 1
            self.labelLossCount.text = "\(self.lostCount)"
            self.showAlert(status: false)
        default:
            print("failed")
        }
    }
}


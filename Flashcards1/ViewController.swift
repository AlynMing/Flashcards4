//
//  ViewController.swift
//  Flashcards1
//
//  Created by Taia Williams on 2/22/20.
//  Copyright © 2020 Taia Williams-Rivera. All rights reserved.
//

import UIKit

struct Flashcard{
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var card: UIView!
    
    var flashcards = [Flashcard]()
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        readSavedFlashcards()
        if flashcards.count == 0{
            updateFlashcard(question: "How many boroughs are in NYC ?", answer: "5")
        }else{
            updateLabels()
            updateNextPrevButtons()
        }
    }
    
    @IBAction func didTapFlashcard(_ sender: Any) {
        UIView.transition(with: card, duration: 0.3, options: .transitionFlipFromRight, animations: {
            self.frontLabel.isHidden=true
        })
        flipFlashcard()
    }
    func flipFlashcard(){
      frontLabel.isHidden=true
    }
    func updateFlashcard(question: String, answer: String) {
        let flashcard = Flashcard(question: question, answer: answer)
        flashcards.append(flashcard)
        //frontLabel.text = flashcard.question
        //backLabel.text = flashcard.answer
        print("added a new flashcard")
        print("We now have \(flashcards.count) flashcards")
        currentIndex = flashcards.count-1
        print("Our current index is \(currentIndex)")
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let navigationController = segue.destination as! UINavigationController
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }
    
    @IBAction func didTapOnPrev(_ sender: Any) {
         currentIndex = currentIndex-1
         updateLabels()
         updateNextPrevButtons()
        animateCardIn()
    }
    @IBAction func didTapOnNext(_ sender: Any) {
        currentIndex = currentIndex+1
        updateLabels()
        updateNextPrevButtons()
        animateCardOut()
    }
    
    func updateNextPrevButtons(){
        if currentIndex == flashcards.count-1{
            nextButton.isEnabled = false
        } else{
            nextButton.isEnabled = true
        }
    }
    func updateLabels(){
        let currentFlashcard = flashcards[currentIndex]
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
    }
    func saveAllFlashcardsToDisk(){
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return["question": card.question, "answer": card.answer]
        }
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcards saved to UserDefaults")
    }
    func readSavedFlashcards(){
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
                
            }
            flashcards.append(contentsOf: savedCards)
        }
    }
    func animateCardOut(){
        UIView.animate(withDuration: 0.3, animations: {
            self.card.transform = CGAffineTransform.identity.translatedBy(x: -300.0, y: 0.0)
        }, completion: {finished in
            self.updateLabels()
            self.animateCardIn()
        })
    }
    func animateCardIn(){
        card.transform = CGAffineTransform.identity.translatedBy(x: 300.0, y: 0.0)
        UIView.animate(withDuration: 0.3){
            self.updateLabels()
            self.card.transform = CGAffineTransform.identity
        }
    }
    


}


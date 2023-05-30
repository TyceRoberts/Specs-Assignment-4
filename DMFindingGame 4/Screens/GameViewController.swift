//
//  GameViewController.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 2/19/23.
//

import UIKit


let gameBrain = GameBrain.shared


class GameViewController: UIViewController {
    
    
    
    /**
     5.1 Create IBOutlets for the target letter label, the score label, and the seconds label. Also, create an IBOutlet collection for the letter buttons.
     */
    
    //IBOutlet collection for letter buttons
    
    @IBOutlet var letterLables: [UIButton]!
    
    //letter, score, and time labels
    
    @IBOutlet weak var targetLetterLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    //button labels
    
    
    var timer: Timer!
    
    
    
    /**
     6.1 Use the game brain to start a new game. Hint: We want the number of letters to be the number of letters buttons that we have.
     6.2 Create a function that uses the game brain to update the target letter label, the score label, the seconds label, and the title of each letter button. Call the function here.
     6.3 Call the provided `configureTimer` function.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        updateUI()
        configureTimer()
    }
    
    
    
    
    func configureTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: fireTimer(timer:))
        
        RunLoop.current.add(timer, forMode: .common)
    }
    
    /*
     We are invalidating the timer when the screen disappears. You do not need to modify this code.
     */
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        timer.invalidate()
    }
    
    /*
     You do not need to modify this code.
     */
    func updateUI() {
        targetLetterLabel.text = GameBrain.shared.targetLetter
        scoreLabel.text = "Score: \(GameBrain.shared.score)"
        secondsLabel.text = "Seconds: \(GameBrain.shared.secondsRemaining)"
        
        _ = Int.random(in: 0..<letterLables.count)
        
        for (index, button) in letterLables.enumerated() {
            let letter = GameBrain.shared.randomLetters[index]
            button.setTitle(letter, for: .normal)
            
            // Check if the button's title matches the target letter
            if letter == GameBrain.shared.targetLetter {
                button.backgroundColor = .red
                button.setTitleColor(.white, for: .normal) // Set text color to white for better visibility
            } else {
                button.backgroundColor = .clear
                button.setTitleColor(.white, for: .normal) // Set text color to black for other buttons
            }
        }
    }
    
    
    func moveLetterButtons() {
        for _ in letterLables {
            _ = CGFloat.random(in: -50...50)
            
        }
    }
    /**
     7.1 Use the game brain to process the selected letter and call `updateUI`.
     */
    @IBAction func letterButtonTapped(_ sender: UIButton) {
        let selectedLetter = sender.currentTitle ?? ""
        GameBrain.shared.letterSelected(selectedLetter)
        updateUI()
        
        // Move the letter buttons
        moveLetterButtons()
    }
    
    /*
     8.1 This function will get called automatically every second. Uncomment the provided code and add one more line of code inside the conditional to transition the user back to the start screen.
     */
    
    
    func fireTimer(timer: Timer) {
        GameBrain.shared.secondsRemaining -= 1
        secondsLabel.text = "Seconds: \(GameBrain.shared.secondsRemaining)"
        
        
        
        //This code keeps the seconds remaining countdown on the label
        if GameBrain.shared.secondsRemaining <= 0 {
            timer.invalidate()
            StartViewController.shared.highScoreLabel = scoreLabel
            
            
            
            if GameBrain.shared.secondsRemaining <= 0 {
                timer.invalidate()

                // Save the score when the game is over
                CoreDataManager.shared.addScore(score: GameBrain.shared.score)
                GameBrain.shared.previousScore = GameBrain.shared.score

                // Schedule the transition back to the start screen after a slight delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            navigationController?.popViewController(animated: true)
            
        }
        
        
    }
    
    func startNewGame() {
        let numLetters = letterLables.count
        GameBrain.shared.newGame(numLetters: numLetters)
    }
}

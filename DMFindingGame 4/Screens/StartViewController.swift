//
//  StartViewController.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 4/17/23.
//

import UIKit

/**
 1.1 Create the user interface. The app will have two screens: the start screen and the game screen. The start screen will be controlled by the `StartViewController`, and the game screes will be controlled by the `GameViewController`.  See the provided screenshots and video for how the UI should look. Feel free to customize the colors, font, etc.
 1.2 Create an IBOutlet for the high score label.
 */


class StartViewController: UIViewController {
    
    
    //MARK: - Labels
    
    @IBOutlet weak var previousScoreLabel: UILabel!
    @IBOutlet weak var highScoreTitleLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var welcomeTitleLabel: UILabel!
    
    static let shared = StartViewController()
    
    let gameBrain = GameBrain.shared
    
    
    
    /**
     3.1 Update the `highScoreLabel`'s text to be the high score from the game brain.
     */
    
    
    
    //MARK: - Lifecycle Functions
    
    @objc func updateHighScore() {
        highScoreLabel.text = "\(GameBrain.shared.highScore)"
        
    }
    
    @IBAction func seeAllScoresTapped(_ sender: UIButton) {
        let seeAllScoresVC = SeeAllScoresViewController() // Create an instance of SeeAllScoresViewController
        navigationController?.pushViewController(seeAllScoresVC, animated: true) // Push it onto the navigation stack
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(updateHighScore), name: Notification.Name("HighScoreUpdated"), object: nil)
        
        
        // Fetch all the scores from CoreData and display them
        
        _ = CoreDataManager.shared.fetchScores()
        
        previousScoreLabel.text = "\(GameBrain.shared.previousScore)"
        
        //Creating some animation using for loops and delayed time for cosmetics
        
        highScoreLabel.text = "\(gameBrain.highScore)"
        
        welcomeTitleLabel.text = ""
        
        var charIndex = 0.0
        
        let welcomeTitleText = ("Welcome To The Letter Finding Game!")
        for letter in welcomeTitleText {
            print("-")
            print(0.05 * charIndex)
            print(letter)
            Timer.scheduledTimer(withTimeInterval: 0.05 * charIndex, repeats: false) {
                (timer) in self.welcomeTitleLabel.text?.append(letter)
                
                
                
                charIndex += 1
            }
        }
        
        
        
        
        /**
         4.1 Transition the user to the `GameViewController`.
         */
        
        
    }//End of class
    
}

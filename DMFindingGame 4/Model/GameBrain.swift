//
//  GameBrain.swift
//  DMFindingGame
//
//  Created by David Ruvinskiy on 4/17/23.
//

import Foundation

/**
 2.1 Create a class called `GameBrain`. `GameBrain` will be a singleton that can be accessed in `StartViewController` and `GameViewController`. The code that makes this class a singleton is provided.
 
 A `GameBrain` should have the following properties:
 
 - A String `targetLetter` initially set to an empty String
 - A [String] `randomLetters` initially set to an empty array
 - An Int `score` initially set to 0
 - An Int `highScore` initially set to 0
 - An Int `numLetters` initially set to 0
 - An Int `secondsRemaining` set to 30
 - An Int `letters` set to 30
 - A [String] `letters` set to the letters of the alphabet.
 
 A `GameBrain` should also have the following methods:
 
 - `generateRandomLetters`:  Returns an array of letters. There should be as many letters as `numLetters`. The array should include the target letter. The rest of the letters should be random. A letter should show up in the array only once. The order of the letters should be random.
 
 - `newRound`: Sets the `targetLetter` to a random letter from the `letters` array and sets `randomLetters` to the result of calling `generateRandomLetters`.
 
 - `newGame`:  Accepts the number of letters for the game and assigns `numLetters` accordingly. Also sets the `score` to 0, sets the `secondsRemaining` to 30, and calls `newRound`.
 
 - `letterSelected`: Accepts the letter the user selected and updates the `score` and `highScore` accordingly. Also, calls `newRound`.
 
 Run the tests in `DMFindingGameTests` to make sure your code is correct.
 */
class GameBrain {
    static let shared = GameBrain()
    
    private let alphabetLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    
    var hasPlayedFirstGame: Bool = false
    var previousScore: Int = 0
    var targetLetter: String = ""
    var randomLetters: [String] = []
    var score: Int = 0
    //var highScore: Int = 0
    var numLetters: Int = 0
    var secondsRemaining: Int = 30
    
    private init() {
        // Private initializer to prevent external instantiation
    }
    
    func generateRandomLetters() -> [String] {
        var availableLetters = Array(alphabetLetters)
        var generatedLetters: [String] = []
        
        // Include the target letter
           generatedLetters.append(targetLetter)
           
           // Generate remaining random letters
           for _ in 1...(numLetters - 1) {
               let randomIndex = Int.random(in: 0..<availableLetters.count)
               let randomLetter = String(availableLetters.remove(at: randomIndex))
               generatedLetters.append(randomLetter)
           }
           
           // Ensure only one button displays the target letter
           let randomButtonIndex = Int.random(in: 0..<numLetters)
           generatedLetters = Array(repeating: "", count: numLetters)
           generatedLetters[randomButtonIndex] = targetLetter
           
           // Replace empty strings with random letters
           var availableIndices = Array(0..<numLetters)
           availableIndices.remove(at: randomButtonIndex)
           
           for index in availableIndices {
               let randomLetterIndex = Int.random(in: 0..<availableLetters.count)
               let randomLetter = String(availableLetters.remove(at: randomLetterIndex))
               generatedLetters[index] = randomLetter
           }
           
           return generatedLetters
    }
    
    func newRound() {
        targetLetter = String(alphabetLetters.randomElement()!)
        randomLetters = generateRandomLetters()
    }
    
    func newGame(numLetters: Int) {
       
        self.numLetters = numLetters
        self.score = 0
        self.secondsRemaining = 30
        self.newRound()
    }
    
    var highScore: Int {
        get {
            return UserDefaults.standard.integer(forKey: "HighScore")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "HighScore")
        }
    }

    
    
    func letterSelected(_ letter: String) {
        if letter == targetLetter {
            score += 1
            if score > highScore {
                highScore = score
                
                NotificationCenter.default.post(name: NSNotification.Name("HighScoreUpdated"), object: nil)
            }
        }
        
        newRound()
    }
}


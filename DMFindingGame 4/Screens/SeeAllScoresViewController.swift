//
//  SeeAllScoresViewController.swift
//  DMFindingGame
//
//  Created by tyce roberts on 5/26/23.
//

import UIKit

class SeeAllScoresViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var scoresTableView: UITableView!
    
    var scores: [Int] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up tabel view when view loads
        setupTableView()
        
        //assign scores to scores label
        scores = CoreDataManager.shared.fetchScores()
        
        scoresTableView.reloadData()
    }
    
    
    // MARK: - UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath)
        
        // Get the score for this row
        let score = scores[indexPath.row]
        
        // Set the text of the cell to the score
        cell.textLabel?.text = "\(score)"
        
        return cell
    }
    
    
    private func setupTableView() {
        scoresTableView.dataSource = self
        scoresTableView.delegate = self
    }
}



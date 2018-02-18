//
//  ResultViewController.swift
//  Quiz
//
//  Created by Raghavendra Shedole on 18/02/18.
//  Copyright © 2018 Raghavendra Shedole. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    var noOfCorrectAns = 0
    var noOfWrongAns = 0
    var noOfNotAns = 0

    @IBOutlet weak var correctAnswers: UILabel!
    @IBOutlet weak var wrongAnswers: UILabel!
    @IBOutlet weak var notAnswered: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        correctAnswers.text = "correct Answers : \(noOfCorrectAns)"
        wrongAnswers.text = "Wrong Answer : \(noOfWrongAns)"
        notAnswered.text = "Not Answered : \(noOfNotAns)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
